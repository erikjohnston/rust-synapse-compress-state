FROM rust:1.49-buster AS builder
WORKDIR /usr/src

RUN USER=root cargo new synapse-compress-state
WORKDIR /usr/src/synapse-compress-state
COPY Cargo.toml Cargo.lock ./
COPY src ./src
RUN cargo install --path .

FROM debian:buster
COPY --from=builder /usr/local/cargo/bin/synapse-compress-state /usr/local/bin/synapse-compress-state
ENTRYPOINT ["/usr/local/bin/synapse-compress-state"]
