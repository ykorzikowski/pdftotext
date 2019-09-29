FROM alpine:3.4

MAINTAINER Yannik Korzikowski <yannik@korzikowski.de>

RUN apk add --no-cache poppler-utils \
    && apk update \
    && apk add bash grep perl

WORKDIR /app

COPY /scripts /app
COPY /filters /filters

ENTRYPOINT ["/app/run_pdf_scan.sh"]
