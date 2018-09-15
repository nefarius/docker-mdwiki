FROM golang:alpine
LABEL maintainer="nefarius@dhmx.at"

ENV FS_OPT=/opt
ENV FS_SRV=/srv

RUN apk --update add git gettext supervisor

RUN go get github.com/cortesi/devd/cmd/devd
RUN go get github.com/adnanh/webhook

RUN mkdir -p ${FS_OPT}

COPY index.html ${FS_SRV}

COPY hooks.json.tpl ${FS_OPT}
COPY handle-webhook.sh ${FS_OPT}
RUN chmod +x ${FS_OPT}/handle-webhook.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80/tcp
EXPOSE 9000/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

