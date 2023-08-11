FROM docker-ls:latest 

RUN eval $(opam env) && opam update && opam install \
    satysfi-class-stjarticle \
    && satyrographos install

