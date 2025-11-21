FROM alpinelinux/unbound@{{UpstreamImageDigest}}

LABEL maintainer="iGoX <code@igox.org>"
LABEL description="Lightweight Unbound DNS server with native healcheck support"
LABEL url="https://github.com/igox/unbound-customized"
LABEL alpinelinux.unbound.upstream.image.digest="{{UpstreamImageDigest}}"
LABEL alpinelinux.unbound.upstream.unbound.version="{{UpstreamUnboundVersion}}"

COPY ./docker/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD /usr/local/bin/healthcheck.sh

RUN apk add --no-cache drill
