FROM alpinelinux/unbound@{{UpstreamImageDigest}}

LABEL maintainer="iGoX <code@igox.org>"
LABEL description="Lightweight Unbound DNS server with native healcheck support"
LABEL url="https://github.com/igox/unbound-customized"
LABEL upstream.alpinelinux.unbound.image.digest.="{{UpstreamImageDigest}}"
LABEL upstream.alpinelinux.unbound.unbound.version="{{UpstreamUnboundVersion}}"

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

RUN apk add --no-cache drill
