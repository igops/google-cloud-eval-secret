FROM google/cloud-sdk:alpine
LABEL maintainer="igops <hi@igops.me>"

ENV SECRET_VERSION latest

WORKDIR /usr/local/bin
COPY docker-entrypoint.sh .
RUN chmod +x ./docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
