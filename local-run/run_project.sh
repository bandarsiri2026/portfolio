#!/usr/bin/env bash
# Run one of the staged Laravel projects locally in Docker (PHP 7.4 + MySQL 5.7).
#   ./run_project.sh study-in-ukraine-portal      -> http://localhost:8000
#   ./run_project.sh svetilo-lighting-shop        (needs MySQL seeded from the private dump)
set -euo pipefail
PROJECT="${1:-study-in-ukraine-portal}"
HERE="$(cd "$(dirname "$0")" && pwd)"
NAME="php74-$PROJECT"

docker build --platform linux/amd64 -t php74-laravel "$HERE"
if ! docker ps | grep -q mysql57; then
  docker run -d --name mysql57 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app -p 3306:3306 mysql:5.7
fi
docker rm -f "$NAME" >/dev/null 2>&1 || true
docker run -d --name "$NAME" -p 8000:8000 \
  -v "$HERE/../$PROJECT:/app" \
  -e DB_HOST=mysql57 -e DB_DATABASE=app -e DB_USERNAME=root -e DB_PASSWORD=root \
  php74-laravel bash -c 'composer install --no-interaction; cp .env.example .env 2>/dev/null || true; php artisan key:generate; php artisan serve --host=0.0.0.0 --port=8000'

echo "waiting for the app to boot..."
for i in $(seq 1 60); do
  code=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8000/ || true)
  if [ "$code" = "200" ]; then echo "OK: $PROJECT is serving at http://localhost:8000 (HTTP 200)"; break; fi
  sleep 5
done
