FROM alpine:3.4

MAINTAINER Yannik Korzikowski <yannik@korzikowski.de>

RUN apk add --no-cache poppler-utils

WORKDIR /app

COPY --from=builder /scripts /app/

ENTRYPOINT ["/app/pdf_filter.sh"]
