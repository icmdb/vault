
ARG GOOS=linux
ARG GOARCH=amd64
ARG VAULT_VERSION=1.4.1
ARG ALPINE_VERSION=3.11

FROM alpine:${ALPINE_VERSION} as build
ADD . /tmp/vault

ARG GOOS
ARG GOARCH
ARG VAULT_VERSION
RUN    set -x \
    && test -s /tmp/vault/vault_${VAULT_VERSION}_${GOOS}_amd64.zip || wget -c -P /tmp/vault/ https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_${GOOS}_${GOARCH}.zip \
    && mkdir -p /go/bin/ \
    && unzip -d /go/bin/  /tmp/vault/vault_${VAULT_VERSION}_${GOOS}_${GOARCH}.zip \
    && chmod +x /go/bin/*


ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}
LABEL maintainer="ihanyouqing@gmail.com"

ENV PATH=${PATH}:/go/bin \
    VAULT_VERSION=${VAULT_VERSION} \
    VAULT_ADDR=http://0.0.0.0:8200 

COPY --from=build /go/bin/ /go/bin/
WORKDIR /go/bin/
EXPOSE 8200 8201
CMD ["/go/bin/vault", "server", "-dev", "-dev-listen-address=0.0.0.0:8200"]
