FROM stackbrew/debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

# install typical php packages and then additional packages
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php5-curl php5-gd php5-fpm php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mysql &&\
	DEBIAN_FRONTEND=noninteractive apt-get install -y dnsutils imagemagick ssmtp wget whois)

# enable new relic agent
RUN (wget -O - http://download.newrelic.com/548C16BF.gpg | apt-key add - &&\
	sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list' &&\
	apt-get update &&\
	DEBIAN_FRONTEND=noninteractive apt-get install -y newrelic-php5)
	
#newrelic-install install

# disable daemonization
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

# add run script
ADD run.sh /usr/local/bin/run

#VOLUME ["/run"]
ENTRYPOINT ["/usr/local/bin/run"]
CMD ["/usr/sbin/php5-fpm","-R","--fpm-config","/etc/php5/fpm/php-fpm.conf"]
