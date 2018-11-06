FROM alpine:3.8

ENV ENABLE_TELEMETRY="false"
WORKDIR /app
RUN apk add --no-cache git openssh-client \
  && adduser -S smk \
  && chown -R smk:0 /app && chmod -R 770 /app
USER smk
EXPOSE 8080
CMD ["/go/caddy", "-quic", "--conf", "/conf/Caddyfile"]
