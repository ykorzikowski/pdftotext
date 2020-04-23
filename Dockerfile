FROM alpine:3

MAINTAINER Yannik Korzikowski <yannik@korzikowski.de>

ARG UID=1000

RUN apk add --no-cache poppler-utils \
    && apk update \
    && apk add bash grep perl procmail

RUN adduser --uid $UID --disabled-password --home /app pdf

WORKDIR /app

COPY /scripts /app
COPY /filters /filters

RUN chown -R pdf:pdf /app
RUN chmod -R +x /app

USER pdf

ENTRYPOINT ["/app/run_pdf_scan.sh"]
