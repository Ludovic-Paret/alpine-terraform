FROM alpine:3.7

ENV TERRAFORM_VERSION "0.11.3"

ARG RUNTIME_DEPS="libintl git"
ARG BUILD_DEPS="gnupg gettext openssl curl"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_DEPS} && \
    apk add --no-cache --virtual build-dependencies ${BUILD_DEPS} && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    curl -s https://keybase.io/hashicorp/key.asc | gpg --import && \
    curl -Os https://releases.hashicorp.com/terraform/${VERSION_TERRAFORM}/terraform_${VERSION_TERRAFORM}_linux_amd64.zip && \
    curl -Os https://releases.hashicorp.com/terraform/${VERSION_TERRAFORM}/terraform_${VERSION_TERRAFORM}_SHA256SUMS && \
    curl -Os https://releases.hashicorp.com/terraform/${VERSION_TERRAFORM}/terraform_${VERSION_TERRAFORM}_SHA256SUMS.sig && \
    gpg --verify terraform_${VERSION_TERRAFORM}_SHA256SUMS.sig terraform_${VERSION_TERRAFORM}_SHA256SUMS && \
    sha256sum terraform_${VERSION_TERRAFORM}_SHA256SUMS && \
    unzip terraform_${VERSION_TERRAFORM}_linux_amd64.zip && \
    chmod +x terraform && \
    mv terraform /usr/local/bin/terraform && \
    apk del build-dependencies && \
    rm -rf terraform_${VERSION_TERRAFORM}_* /var/cache/apk/* /tmp/*

ENTRYPOINT []
