#!/bin/bash

# Script de validación de credenciales GitHub

echo "🔍 Validando variable de entorno GITHUB_TOKEN..."
if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ No está definida la variable GITHUB_TOKEN"
else
  echo "✅ GITHUB_TOKEN está definida"
fi

echo "🔍 Validando archivo ~/.git-credentials..."
if [ -f ~/.git-credentials ]; then
  cat ~/.git-credentials
else
  echo "❌ No existe ~/.git-credentials"
fi

echo "🔍 Probando acceso remoto con git ls-remote..."
git ls-remote https://github.com/MARO0687/mi_proyecto.git &>/dev/null

if [ $? -eq 0 ]; then
  echo "✅ Autenticación correcta, puedes clonar sin problemas"
else
  echo "❌ Falló la autenticación, revisa tu token o credenciales"
fi