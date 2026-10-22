#!/usr/bin/env bash
# Run one of the legacy Laravel projects locally with Docker (PHP 7.4 + MySQL 5.7).
#
# Clone the project repos into one folder, then from that folder run:
#   ./local-run/run_project.sh study-in-ukraine-portal     -> http://localhost:8000/en
#   ./local-run/run_project.sh svetilo-lighting-shop       -> http://localhost:8001 (needs a catalogue dump)
set -euo pipefail

PROJECT="${1:-study-in-ukraine-portal}"
PORT="${2:-8000}"
HERE="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(pwd)/$PROJECT"
NAME="php74-$PROJECT"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Project folder not found: $PROJECT_DIR"
  echo "Clone the repo first, e.g. git clone https://github.com/bandarsiri2026/$PROJECT"
  exit 1
fi

docker network create portfolio-net >/dev/null 2>&1 || true

if ! docker ps | grep -q mysql57; then
  docker run -d --name mysql57 --network portfolio-net \
    -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3306:3306 mysql:5.7 >/dev/null
fi

docker build --platform linux/amd64 -t php74-laravel "$HERE" >/dev/null
docker rm -f "$NAME" >/dev/null 2>&1 || true

docker run -d --name "$NAME" --network portfolio-net -p "$PORT:8000" \
  -v "$PROJECT_DIR:/app" \
  php74-laravel bash -c '
    composer install --no-interaction
    if [ ! -f .env ]; then cp .env.example .env; fi
    sed -i "s/DB_HOST=.*/DB_HOST=mysql57/;s/DB_USERNAME=.*/DB_USERNAME=root/;s/DB_PASSWORD=.*/DB_PASSWORD=root/" .env
    php artisan key:generate
    php artisan serve --host=0.0.0.0 --port=8000
  ' >/dev/null

echo "Waiting for $PROJECT to boot on port $PORT ..."
for i in $(seq 1 60); do
  code=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:$PORT/" || true)
  if [ "$code" = "200" ]; then
    echo "OK: http://localhost:$PORT (HTTP 200)"
    exit 0
  fi
  sleep 5
done
echo "The app did not respond; check: docker logs $NAME"
