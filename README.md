# unbound-customized

This is a very slickly modified [`alpinelinux/unbound`](https://hub.docker.com/r/alpinelinux/unbound) docker image to include the `drill` DNS tool.
You can see the changes made to the upstream image in the [Dockerfile](./Dockerfile)

Aim is to be able to put in place a docker compose health check when using this container.

Add the following `health_check` section in your `docker-compose.yml` file:

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
™

# Change Log

See the [CHANGELOG.md](./CHANGELOG.md) file.