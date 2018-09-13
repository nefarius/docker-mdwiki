FROM golang:alpine
LABEL maintainer="nefarius@dhmx.at"

RUN apk update
RUN apk add git

RUN go get github.com/cortesi/devd/cmd/devd

COPY index.html /srv/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["devd", "-a", "-l", "-w", "/srv/htdocs", "/srv/htdocs"]
