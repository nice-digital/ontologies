FROM nice/ld-docker-app
MAINTAINER Ryan Roberts <ryansroberts@gmail.com>


# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

# Define working directory.
WORKDIR /etc/nginx

RUN rm -rf /var/www/html/*
ADD ns /var/www/html/ns

RUN rm /etc/nginx/sites-enabled/default

ADD site.conf /etc/nginx/sites-enabled/

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
