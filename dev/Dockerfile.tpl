FROM alpinelinux/unbound@{{UpstreamDigest}}
RUN apk add --no-cache drill
