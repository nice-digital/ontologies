FROM nice/ld-docker-app
MAINTAINER Ryan Roberts <ryansroberts@gmail.com>

ADD ns /
ADD index.js /

EXPOSE  80
CMD ["node", "index.js"]
