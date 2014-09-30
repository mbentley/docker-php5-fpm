mbentley/php5-fpm
==================

docker image for php5-fpm
based off of stackbrew/debian:jessie

To pull this image:
`docker pull mbentley/php5-fpm`

Example usage:
`docker run -i -t mbentley/php5-fpm`

In the Dockerfile, there are options that show how to make php5-fpm listen on port 9000.  By default, this image just uses the default option of using a UNIX socket.
