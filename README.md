mbentley/php5-fpm
==================

docker image for php5-fpm
based off of stackbrew/debian:jessie

To pull this image:
`docker pull mbentley/php5-fpm`

Example usage:
`docker run -i -t mbentley/php5-fpm`

In the Dockerfile, there are examples that show how to make php5-fpm listen on port 9000.  This image just uses the default option of using a UNIX socket but feel free to fork it and modify it for yourself.

## Working with nginx + php5-fpm

First start a PHP container:
`docker run -itd –restart=always -v /data/shared/run:/run -v /data/www:/data/www -v /data/shared/ssmtp:/etc/ssmtp –name php5-fpm mbentley/php5-fpm`

I use a volume to /data/shared/run on the host and then I also use a volume to /data/www on the host. /data/shared/run will get the UNIX socket as it is mapped to /run. I use /data/www so that php5-fpm has access to the files it needs to process requests.

Now for my nginx container:
`docker run -itd -p 80 –restart=always -v /data/shared/run:/run -v /data/www:/data/www -v /data/shared/nginx/my-custom-nginx-conf:/etc/nginx/sites-available/default –name my-site mbentley/nginx`

I need to present /data/shared/run as a volume so that nginx can read the UNIX socket (see my [php.conf](https://github.com/mbentley/docker-nginx/blob/master/php.conf) in [mbentley/nginx](https://github.com/mbentley/docker-php5-fpm) which adds all of the necessary bits for PHP by including a single file). I also add in my /data/www directory which shares my site's code for nginx.

Now you should be able to hit nginx and PHP pages will work. I'm using this method for a small number of sites and it's working great.
