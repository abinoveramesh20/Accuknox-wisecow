FROM alpine:latest
WORKDIR /app

RUN apk update && apk add --no-cache fortune netcat-openbsd
RUN wget -O /usr/bin/cowsay https://github.com/tnalpgge/rank-amateur-cowsay/raw/master/cowsay && \
    chmod +x /usr/bin/cowsay

COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

EXPOSE 4499
CMD ["/app/wisecow.sh"]
