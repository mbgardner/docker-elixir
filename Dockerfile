FROM alpine:3.5

LABEL description="Erlang and Elixir installed on top of Alpine. The \
image includes Hex and Rebar."

RUN apk --update add erlang && rm -rf /var/cache/apk/*

ENV ELIXIR_VERSION 1.4.2

RUN apk --update add --virtual build-dependencies wget ca-certificates && \
    wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    apk del build-dependencies && \
    rm -rf /etc/ssl && \
    rm -rf /var/cache/apk/*

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN apk --update add erlang-crypto erlang-syntax-tools erlang-parsetools erlang-inets erlang-ssl erlang-public-key erlang-eunit \
    erlang-asn1 erlang-sasl erlang-erl-interface erlang-dev wget git gcc make libc-dev libgcc && \
    rm -rf /var/cache/apk/*

RUN mix local.hex --force && mix local.rebar --force

CMD ["/bin/sh"]
