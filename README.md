# docker-mdwiki

Lightweight docker image hosting an [MDwiki](http://dynalon.github.io/mdwiki/#!index.md) instance with content fetched from a GitHub repository.

## About

`docker-mdwiki` is a simple and light container based on the [golang (Alpine) image](https://hub.docker.com/_/golang/). Upon startup it clones a specified GitHub repositository and serves its content with [devd](https://github.com/cortesi/devd). Additionally it listens for an incoming Github Webhook and automatically pulls changes upon receiving a push notification. Webhooks are processed by the included [webhook](https://github.com/adnanh/webhook) server. These services are managed by [supervisord](http://supervisord.org/).

## Build

```shell
docker build -t nefarius/docker-mdwiki https://github.com/nefarius/docker-mdwiki.git#master
```

## Run

### Standalone

```shell
docker run --name=docker-mdwiki \
    --restart=always \
    -e GIT_CLONE_URL=https://github.com/ViGEm/docs.vigem.org.git \
    -e WEBHOOK_ID=4648cc7a-f8aa-4705-90a2-d7958d57d462 \
    -e WEBHOOK_SECRET=y9b3nTwR95ejCgNZ \
    -p 127.0.0.1:1601:80 \
    -p 127.0.0.1:1602:9000 \
    -d nefarius/docker-mdwiki:latest
```

### Compose file

```docker-compose
version: "3"

services:
  mdwiki:
    image: nefarius/docker-mdwiki:latest
    container_name: mdwiki
    environment:
      - GIT_CLONE_URL=https://github.com/ViGEm/docs.vigem.org.git
      - WEBHOOK_ID=4648cc7a-f8aa-4705-90a2-d7958d57d462
      - WEBHOOK_SECRET=y9b3nTwR95ejCgNZ
    ports:
      - "127.0.0.1:1601:80"
      - "127.0.0.1:1602:9000"
    restart: always

```

## Nginx as reverse proxy

This snippet exposes the Wiki at the root of `http://example.org` while a push notification can be sent to `http://example.org/hooks/4648cc7a-f8aa-4705-90a2-d7958d57d462` (matching the ID referenced in the environment variable).

```
server {
  listen 80;
  server_name example.org;

  access_log /var/log/nginx/example.org_access.log;
  error_log /var/log/nginx/example.org_error.log;
  
  location / {
    proxy_pass http://127.0.0.1:1601;
  }

  location /hooks {
    proxy_pass http://127.0.0.1:1602;
  }
}
```

## GitHub Webhook example configuration

![Webhook](https://lssotw.am.files.1drv.com/y4mHRukV8maB7RQMoudcOLM5AydCv9LvszwvLYk-_zhItcnEwJ-KPVuzUx6iWbgNzg3o_4DMeUtc9_03lx7038KoDguY4Bl4jQu1qRYfAHwsZZXHVS8mT_-kfojAzf1B0CjpVPIkhapmNyNTooySHSWy2LRUt2wmvamaDpit56sXUBJup0LvDsdJSkrr1y5R7ad799dhbrviopbw3Bfupii5w?width=574&height=641&cropmode=none)

## Environment variables

Variable | Value (example)
--- | ---
`GIT_CLONE_URL` | `https://github.com/ViGEm/docs.vigem.org.git`
`WEBHOOK_ID` | `webhookid`
`WEBHOOK_SECRET` | `mysecret`
