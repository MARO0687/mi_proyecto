# Etapa de construcción
FROM rust:1.94-slim as builder

WORKDIR /usr/src/app
COPY Cargo.toml Cargo.lock ./

# Copiamos el código fuente
COPY src ./src

# Instalamos dependencias de compilación necesarias para reqwest/openssl si fuera necesario
# (aunque reqwest por defecto usa rustls en este setup)
RUN cargo build --release

# Etapa de ejecución
FROM debian:bookworm-slim

#Instalamos certificados CA para que las peticiones HTTPS funcionen correctamente
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/target/release/apiGitHub .

CMD ["./apiGitHub"]