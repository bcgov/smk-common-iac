FROM alpine:3.7
MAINTAINER databcmaps@gov.bc.ca

ARG plugins=http.cors,http.realip,http.git
ARG http_port=8080

WORKDIR /app
RUN apk update \
 && apk --no-cache add git openssh-client \
 && apk --no-cache add --virtual devs tar curl \
 && curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=$plugins&license=personal" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version \
 && adduser -S app \
 && chown -R app:0 /app && chmod -R 770 /app \
 && apk del --purge devs

USER app
EXPOSE 8080
CMD ["caddy", "-quic", "--conf", "/conf/Caddyfile"]
