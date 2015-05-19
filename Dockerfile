FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>

# install typical php packages and then additional packages
RUN (apt-get update &&\
  apt-get install -y wget &&\
  wget -O - http://download.newrelic.com/548C16BF.gpg | apt-key add - &&\
  sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list' &&\
  apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y php5-curl php5-gd php5-fpm php5-imagick php5-mcrypt \
    php5-memcache php5-memcached php5-mysql dnsutils imagemagick ssmtp whois newrelic-php5 &&\
  sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf)

# add run script
ADD run.sh /usr/local/bin/run

ENTRYPOINT ["/usr/local/bin/run"]
CMD ["/usr/sbin/php5-fpm","-R","--fpm-config","/etc/php5/fpm/php-fpm.conf"]
