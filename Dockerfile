FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>

# install typical php packages and then additional packages
RUN apt-get update &&\
  apt-get install -y php5-curl php5-gd php5-fpm php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mysql dnsutils imagemagick ssmtp whois &&\
  sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

# add run script
ADD run.sh /usr/local/bin/run

ENTRYPOINT ["/usr/local/bin/run"]
CMD ["/usr/sbin/php5-fpm","-R","--fpm-config","/etc/php5/fpm/php-fpm.conf"]
