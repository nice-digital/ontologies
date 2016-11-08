FROM anapsix/alpine-java

MAINTAINER Ryan Roberts <ryansroberts@gmail.com>

RUN mkdir /ontologies
ADD . /ontologies/

# Get tools from submodules and generate json.ld files from ttl
RUN cd /ontologies && \
    ./build.sh

# Install Nginx.
RUN apk add --update nginx && rm -rf /var/cache/apk/*

# Define mountable directories.
VOLUME ["/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

RUN mkdir -p /usr/share/nginx/html/ontologies && \
    cp /ontologies/ns/* /usr/share/nginx/html/ontologies

RUN rm -f /etc/nginx/mime.types &&\
    chown -R nginx:nginx /usr/share/nginx/html &&\
    chown nginx:nginx /usr/share/nginx/html/ontologies/*.*

# Define working directory.
WORKDIR /etc/nginx

COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/
COPY mime.types /etc/nginx/

# Define default command.
CMD ln -sf /dev/stdout /var/log/nginx/access.log &&\
    ln -sf /dev/stderr /var/log/nginx/error.log &&\
    nginx

# Expose ports.
EXPOSE 80
EXPOSE 443
