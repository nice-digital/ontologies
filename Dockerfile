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
RUN rm -f /etc/nginx/mime.types

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/sites-available/default.conf
COPY mime.types /etc/nginx/

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# Define default command.
CMD ["nginx", "-g", "daemon off;"]
# Expose ports.
EXPOSE 80
EXPOSE 443
