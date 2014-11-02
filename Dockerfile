FROM stackbrew/debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

# install typical php packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-curl php5-gd php5-fpm php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mysql

# install additional packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dnsutils imagemagick ssmtp whois

# add run script
ADD run.sh /usr/local/bin/run

RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf
#RUN sed -i 's/post_max_size = 8M/post_max_size = 16M/g' /etc/php5/fpm/php.ini
#RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 16M/g' /etc/php5/fpm/php.ini
#RUN sed -i 's/pm.max_children = 5/pm.max_children = 10/g' /etc/php5/fpm/pool.d/www.conf

#RUN sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 9000/g' /etc/php5/fpm/pool.d/www.conf
#EXPOSE 9000

VOLUME ["/run"]
ENTRYPOINT ["/usr/local/bin/run"]
CMD ["/usr/sbin/php5-fpm","-R","--fpm-config","/etc/php5/fpm/php-fpm.conf"]
