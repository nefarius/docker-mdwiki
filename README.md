# docker-mdwiki

## About

TBD

## Build

```shell
docker build -t nefarius/docker-mdwiki https://github.com/nefarius/docker-mdwiki.git#master
```

## Run

```shell
docker run --name docker-mdwiki \
    -e GIT_CLONE_URL=https://github.com/ViGEm/docs.vigem.org.git \
    -e WEBHOOK_ID=webhook \
    -e WEBHOOK_SECRET=mysecret \
    -p 8087:80 \
    -p 9000:9000 \
    -d nefarius/docker-mdwiki:latest
```

## Environment variables

Variable | Value (example)
--- | ---
`GIT_CLONE_URL` | `https://github.com/nefarius/docker-mdwiki.git`
`WEBHOOK_ID` | `webhookid`
`WEBHOOK_SECRET` | `mysecret`
