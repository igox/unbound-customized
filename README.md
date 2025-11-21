# unbound-customized

This is a very minor change to [`alpinelinux/unbound`](https://hub.docker.com/r/alpinelinux/unbound) docker image to include the `drill` DNS tool.

Aim is to add a native health check when using this modified container.

Implemented `health_check` is the following equivalent of `docker compose`:

```
  unbound:
    container_name: unbound
    image: ghcr.io/igox/unbound-cutomized
    
    [...]
    
    healthcheck:
      test: ["CMD", "drill", "@127.0.0.1", "cloudflare.com"]
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 5s

    [...]
```

You can see the changes made to the upstream image in the [Dockerfile](./dev/Dockerfile.tpl) file.
The healthcheck logic into the [healthcheck.sh](./docker/healthcheck.sh) file.

# Change Log

See the [CHANGELOG.md](./CHANGELOG.md) file.