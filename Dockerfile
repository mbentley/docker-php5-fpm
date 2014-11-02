FROM stackbrew/debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

# install typical php packages and then additional packages
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php5-curl php5-gd php5-fpm php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mysql &&\
	RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dnsutils imagemagick ssmtp whois)

# disable daemonization
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

# add run script
ADD run.sh /usr/local/bin/run

VOLUME ["/run"]
ENTRYPOINT ["/usr/local/bin/run"]
CMD ["/usr/sbin/php5-fpm","-R","--fpm-config","/etc/php5/fpm/php-fpm.conf"]
