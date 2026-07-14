#!/bin/bash

# ============================
# CONFIGURAÇÃO
# ============================
REPO_URL="git@github.com:luismetzker/The-Gods-Studio.git"
BRANCH="main"

echo "========================================"
echo "     THE GODS STUDIO - GITHUB UPLOADER"
echo "========================================"

# Verifica se o Git está instalado
if ! command -v git &> /dev/null; then
    echo "Git não está instalado."
    exit 1
fi

# Inicializa caso ainda não exista
if [ ! -d ".git" ]; then
    echo "Inicializando repositório..."
    git init
fi

# Define a branch principal
git branch -M $BRANCH

# Adiciona o remote caso não exista
if ! git remote | grep -q "^origin$"; then
    git remote add origin "$REPO_URL"
fi

echo "Adicionando arquivos..."

# Adiciona TODOS os arquivos e pastas recursivamente
git add .

echo "Criando commit..."

DATA=$(date +"%d/%m/%Y %H:%M:%S")

git commit -m "Backup automático - $DATA" || echo "Nenhuma alteração para commit."

echo "Enviando para GitHub..."

git push -u origin $BRANCH

echo ""
echo "========================================"
echo "UPLOAD CONCLUÍDO!"
echo "========================================"
