FROM satysfi-ls:latest

RUN eval $(opam env) 

RUN opam update && opam install \
    satysfi-class-stjarticle \
    && satyrographos install
