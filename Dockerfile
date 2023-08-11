# Language Server

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

# SATySFi

FROM ubuntu:22.04

COPY --from=0 /workdir/bin/satysfi-language-server  /usr/local/bin/

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential \
    opam \
    bubblewrap \
    git \
    m4 \
    unzip \
    curl \
    pkg-config \
    pdf2svg \ 
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m author
USER author

RUN opam init -y --disable-sandboxing --compiler 4.14.0 \
    && opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git \
    && opam repository add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git \
    && opam update \
    && opam -y depext satysfi satysfi-dist satyrographos \
    && opam install -y satysfi satysfi-dist satyrographos \
    && eval $(opam env) && satyrographos install \
    && echo eval `opam config env` >> ~/.profile

ENTRYPOINT ["/bin/bash"]
