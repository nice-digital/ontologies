FROM alpine

MAINTAINER Ryan Roberts <ryansroberts@gmail.com>

# Install Nginx.
RUN apk add --update nginx && rm -rf /var/cache/apk/*

# Define mountable directories.
VOLUME ["/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

# Define working directory.
WORKDIR /etc/nginx

RUN rm -rf /usr/share/nginx/html/*
ADD ns /usr/share/nginx/html/ns
RUN rm -f /etc/nginx/mime.types &&\
    chown -R nginx:nginx /usr/share/nginx/html &&\
    chown nginx:nginx /usr/share/nginx/html/ns/*.*

COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/
COPY mime.types /etc/nginx/

# Define default command.
CMD ln -sf /dev/stdout /var/log/nginx/access.log &&\
    ln -sf /dev/stderr /var/log/nginx/error.log &&\
    nginx
# Expose ports.
EXPOSE 80
EXPOSE 8083
EXPOSE 443
