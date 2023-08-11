FROM horih/satysfi:latest 

RUN eval $(opam env) && opam update && opam install \
    satysfi-class-stjarticle \
    && satyrographos install

