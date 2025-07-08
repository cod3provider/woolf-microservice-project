#!/bin/bash

set -e

echo "=== Перевірка та встановлення Python 3.9+ ==="
PYTHON_VERSION=$(python3 -V | awk '{print $2}')
PYTHON_MAJOR=$(echo "$PYTHON_VERSION" | cut -d. -f1)
PYTHON_MINOR=$(echo "$PYTHON_VERSION" | cut -d. -f2)

if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 9 ]; then
    echo "Python версії $PYTHON_VERSION вже встановлений."
else
    echo "Оновлюємо Python через brew..."
    brew install python
fi

echo "=== Перевірка та встановлення Docker Desktop ==="
if ! command -v docker &> /dev/null; then
    echo "Будь ласка, встанови Docker Desktop вручну з https://www.docker.com/products/docker-desktop/"
else
    echo "Docker вже встановлений."
fi

echo "=== Перевірка та встановлення Docker Compose ==="
if ! docker compose version &> /dev/null; then
    echo "Будь ласка, переконайся, що у тебе встановлений Docker Desktop, бо Docker Compose встановлюється разом із ним."
else
    echo "Docker Compose вже встановлений."
fi

echo "=== Перевірка та встановлення Django ==="
if python3 -m django --version &> /dev/null; then
    echo "Django вже встановлений."
else
    echo "Встановлюємо Django..."
    pip3 install Django
fi

echo "✅ Встановлення завершено!"