# Run the legacy projects locally (PHP 7.4 + MySQL 5.7 in Docker)

The projects were written for PHP 7.x, so the current system PHP cannot run them.
This folder contains a reproducible Docker environment that boots each Laravel app and lets you
take screenshots or inspect behaviour without installing an old PHP on your machine.

## Requirements

- Docker Desktop (any recent version).
- On Apple Silicon the `php:7.4` arm64 image hangs under Docker 29, so the Dockerfile pins
  `--platform=linux/amd64` and lets Docker emulate it.

## Files

| File | Purpose |
|---|---|
| `Dockerfile` | PHP 7.4 with `pdo_mysql`, `mbstring` and Composer 1.10 (Composer 2 breaks Laravel <= 6, which reads the old `installed.json` format) |
| `run_project.sh <project-dir>` | Builds the image, starts MySQL 5.7, installs dependencies and serves the app on port 8000 |
| `screenshot.sh <url> <out.png>` | Captures a page with headless Chrome |

## Usage

```bash
docker network create portfolio-net 2>/dev/null || true
./run_project.sh study-in-ukraine-portal     # http://localhost:8000/en
./run_project.sh svetilo-lighting-shop       # needs a catalogue dump imported first
```

Seed a database (the real dumps are not published in these repos):

```bash
docker exec mysql57 mysql -uroot -proot -e 'CREATE DATABASE IF NOT EXISTS app;'
docker exec -i mysql57 mysql -uroot -proot app < /path/to/private_dump.sql
```

## Gotchas found while running these apps

1. Composer 2 vs Laravel 5.x: `artisan package:discover` throws `Undefined index: name`. Use Composer 1.10.
2. `davejamesmiller/laravel-breadcrumbs` no longer exists on GitHub, so the Svetilo shop cannot install it.
   Locally we drop that dependency and stub its provider/facade; nothing else in the app uses it.
3. Container DNS: containers must share a user-defined network (`portfolio-net`) to resolve `mysql57` by name;
   the default bridge does not do DNS lookups.
4. Old Debian mirrors: `php:7.4` is based on Debian bullseye (EOL); apt needs the archive mirror for `libonig-dev`.
