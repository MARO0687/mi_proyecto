# Etapa de construcción con musl
FROM rust:1.94-slim AS builder

WORKDIR /usr/src/app

# Copiamos los archivos de configuración
COPY app/Cargo.toml app/Cargo.lock ./
COPY app/src ./src

# Instalamos toolchain musl y compiladores necesarios
RUN apt-get update && apt-get install -y musl-tools musl-dev gcc g++ make cmake pkg-config \
    && rustup target add x86_64-unknown-linux-musl

# Compilamos en modo release con musl
RUN cargo build --release --target x86_64-unknown-linux-musl

# Etapa de ejecución mínima
FROM alpine:latest

RUN apk add --no-cache ca-certificates

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/target/x86_64-unknown-linux-musl/release/apiGitHub .

CMD ["./apiGitHub"]