FROM golang:1.13.3-alpine3.10 as builder
ARG VAULT_VERSION=1.2.2
ARG GOOS=linux
ARG GOARCH=amd64
ARG GOPROXY=
ARG MIRROR=http://dl-cdn.alpinelinux.org
ENV GOPROXY=${GOPROXY}
RUN set -x \
    && sed -i 's#http://dl-cdn.alpinelinux.org#'${MIRROR}'#g' /etc/apk/repositories \
#    && echo "192.30.253.112 github.com" >> /etc/hosts \
#    && echo "151.101.185.194 github.global.ssl.fastly.net" >> /etc/hosts  \
    && apk update && apk add \
           ca-certificates \
           git \
    && mkdir -pv ${GOPATH}/src/github.com/hashicorp/ \
    && go get -v github.com/hashicorp/vault \
    && cd ${GOPATH}/src/github.com/hashicorp/vault 
WORKDIR ${GOPATH}/src/github.com/hashicorp/vault
RUN set -x \
    && git checkout v${VAULT_VERSION} \
    && go tool dist list \
    && echo "${GOOS}/${GOARCH}" > ${GOPATH}/bin/platform \
#    && go env -w GOPRIVATE=*.github.com *.golang.org *.google.com \
    && GOOS=${GOOS} GOARCH=${GOARCH} go build -v -o ${GOPATH}/bin/vault


FROM golang:1.13.3-alpine3.10
LABEL matianer="ihanyouqing@gmail.com"
ENV GOBIN=${GOPATH}/bin
ENV VAULT_VERSION=1.2.2
COPY --from=builder ${GOPATH}/bin/platform ${GOPATH}/bin/platform
COPY --from=builder ${GOPATH}/bin/vault    ${GOPATH}/bin/vault
#CMD ["/go/bin/valut"]
