FROM ubuntu:22.04

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    curl \
    build-essential

WORKDIR /workdir

RUN curl -L https://sh.rustup.rs -o rustup-init  \
    && chmod +x rustup-init \
    && ./rustup-init -y \
    && . "$HOME/.cargo/env" \
    && cargo install --locked --root /workdir --git https://github.com/monaqa/satysfi-language-server.git

FROM amutake/satysfi:nightly

COPY --from=0 /workdir/bin/satysfi-language-server  /usr/bin/

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    pdf2svg \
    git \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m author
USER author
