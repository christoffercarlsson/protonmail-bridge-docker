FROM golang:latest AS build

RUN apt-get update && apt-get install -y libsecret-1-dev

WORKDIR /build/
COPY build.sh VERSION /build/
RUN bash build.sh

FROM ubuntu:jammy
LABEL maintainer="Christoffer Carlsson <cc@christofferc.com>"

EXPOSE 2025/tcp
EXPOSE 2143/tcp

RUN apt-get update -q \
    && apt-get install --no-install-recommends --no-install-suggests --yes \
	    gnupg \
 	    libsecret-1-0 \
 	    pass \
 	    socat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /build/proton-bridge/proton-bridge /protonmail/
COPY entrypoint.sh gpg-params /protonmail/

ENTRYPOINT ["bash", "/protonmail/entrypoint.sh"]
