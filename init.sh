#!/bin/bash

# Script de inicialización para DevContainer con Rust
# Configura el token de GitHub y las credenciales de Git

# 1. Verificar que la variable de entorno GITHUB_TOKEN esté definida
if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ No está definida la variable GITHUB_TOKEN"
  exit 1
fi

# 2. Configurar Git para usar el helper de credenciales
git config --global credential.helper store

# 3. Crear/actualizar el archivo ~/.git-credentials con tu usuario y token
echo "https://MARO0687:${GITHUB_TOKEN}@github.com" > ~/.git-credentials

# 4. Confirmación
echo "✅ Token y credenciales configurados correctamente"
