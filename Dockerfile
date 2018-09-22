FROM golang:alpine
LABEL maintainer="nefarius@dhmx.at"

ENV USER=docker-mdwiki
ENV FS_OPT=/opt
ENV FS_SRV=/srv

RUN apk --update add git gettext supervisor sudo

RUN go get github.com/cortesi/devd/cmd/devd
RUN go get github.com/adnanh/webhook

RUN mkdir -p ${FS_OPT}

COPY assets/index.html ${FS_SRV}

COPY assets/hooks.json.tpl ${FS_OPT}
COPY assets/handle-webhook.sh ${FS_OPT}
RUN chmod +x ${FS_OPT}/handle-webhook.sh

COPY assets/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY assets/supervisord.conf /etc/supervisord.conf

EXPOSE 80/tcp
EXPOSE 9000/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

