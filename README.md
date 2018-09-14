# docker-mdwiki

## About

TBD

## Build

```shell
docker build -t nefarius/docker-mdwiki https://github.com/nefarius/docker-mdwiki.git#master
```

## Run

### Standalone

```shell
docker run --name docker-mdwiki \
    -e GIT_CLONE_URL=https://github.com/ViGEm/docs.vigem.org.git \
    -e WEBHOOK_ID=webhook \
    -e WEBHOOK_SECRET=mysecret \
    -p 8087:80 \
    -p 9000:9000 \
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
      - WEBHOOK_ID=webhook
      - WEBHOOK_SECRET=mysecret
    ports:
      - "127.0.0.1:8088:80"
      - "127.0.0.1:9000:9000"
    restart: always

```

## Nginx as reverse proxy

```
server {
  listen 80;
  server_name example.org;

  access_log /var/log/nginx/example.org_access.log;
  error_log /var/log/nginx/example.org_error.log;
  
  location / {
    proxy_pass http://127.0.0.1:1601;
  }

  location ~* ^/hooks/(.*) {
    proxy_pass http://127.0.0.1:1602/hooks/$1$is_args$args;
  }
}
```

## Environment variables

Variable | Value (example)
--- | ---
`GIT_CLONE_URL` | `https://github.com/nefarius/docker-mdwiki.git`
`WEBHOOK_ID` | `webhookid`
`WEBHOOK_SECRET` | `mysecret`
