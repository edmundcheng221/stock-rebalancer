FROM rust:1.92 AS builder

WORKDIR /usr/src/stock-rebalancer

COPY Cargo.toml Cargo.lock ./

COPY src ./src

RUN cargo build --release

FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/stock-rebalancer

COPY --from=builder /usr/src/stock-rebalancer/target/release/stock-rebalancer /app/server

EXPOSE 8080

CMD ["/app/server"]
