#!/bin/bash
set -e

if ! command -v docker &> /dev/null; then
    apt-get update -y
    apt-get install -y docker.io docker-compose git
    systemctl enable docker
    systemctl start docker
fi

REPO_URL="https://github.com/alejandrobm1daw/ProytectoAmpliacionSistemas.git"
REPO_DIR="/opt/wp-content"

if [ -d "$REPO_DIR/.git" ]; then
    echo "Actualizando repositorio..."
    git -C "$REPO_DIR" pull
else
    echo "Clonando repositorio..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

cd /vagrant
docker-compose up -d --build