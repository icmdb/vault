FROM alpine:3.10.3 as builder
ARG GOOS=linux
ARG GOARCH=amd64
ARG VAULT_VERSION=1.3.0
ADD . /tmp/vault
RUN    set -x \
    && test -s /tmp/vault/vault_1.3.0_${GOOS}_amd64.zip || wget -c -P /tmp/vault/ https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_${GOOS}_${GOARCH}.zip \
    && mkdir -p /go/bin/ \
    && unzip -d /go/bin/  /tmp/vault/vault_${VAULT_VERSION}_${GOOS}_${GOARCH}.zip \
    && chmod +x /go/bin/*


FROM alpine:3.10.3
LABEL maintainer="ihanyouqing@gmail.com"
ENV GOBIN=${GOPATH}/bin
ENV VAULT_VERSION=${VAULT_VERSION}
COPY --from=builder /go/bin/ /go/bin/
WORKDIR /go/bin/
EXPOSE 8200 8201
CMD ["/go/bin/vault", "server", "-dev", "-dev-listen-address=0.0.0.0:8200"]
