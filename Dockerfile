FROM rust:1.88-slim AS builder

WORKDIR /usr/src/stock-rebalancer

COPY Cargo.toml Cargo.lock ./

COPY src ./src

RUN cargo build --release

FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /usr/src/stock-rebalancer/target/release/stock-rebalancer ./stock-rebalancer

EXPOSE 8080

CMD ["./stock-rebalancer"]
