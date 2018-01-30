
FROM ubuntu:latest
MAINTAINER staats.richard@gmail.com

# system installation / dependencies
RUN apt-get -q -y update && \
  apt-get install -y apache2

RUN echo "<html>Hello MetalToad</html>" > /var/www/html/index.html \
    && update-rc.d apache2 enable

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl","-DFOREGROUND"]
