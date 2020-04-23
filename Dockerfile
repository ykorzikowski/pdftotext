FROM alpine:3

MAINTAINER Yannik Korzikowski <yannik@korzikowski.de>

RUN apk add --no-cache poppler-utils \
    && apk update \
    && apk add bash grep perl procmail

RUN adduser --uid 1000 --disabled-password --home /app pdf

WORKDIR /app

COPY /scripts /app
COPY /filters /filters

RUN chown -R pdf:pdf .

USER pdf

ENTRYPOINT ["/app/run_pdf_scan.sh"]
