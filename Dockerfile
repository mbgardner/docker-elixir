FROM elixir:1.7.4-alpine

LABEL description="Hex, and rebar on top of the Elixir alpine image."

RUN apk --update add build-base erlang-crypto erlang-syntax-tools erlang-parsetools erlang-inets erlang-ssl erlang-public-key erlang-eunit \
    	erlang-asn1 erlang-sasl erlang-erl-interface erlang-dev wget git && \
    	rm -rf /var/cache/apk/*

RUN mix local.hex --force \
	&& mix local.rebar --force

CMD ["iex"]
