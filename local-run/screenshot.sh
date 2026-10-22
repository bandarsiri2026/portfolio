#!/usr/bin/env bash
# Capture a screenshot of a running local app with headless Chrome.
#   ./screenshot.sh http://localhost:8000/ screenshots/home.png
set -euo pipefail
URL="${1:-http://localhost:8000/}"
OUT="${2:-screenshots/screen.png}"
mkdir -p "$(dirname "$OUT")"
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless=new --disable-gpu --no-screenshot-off-screen-contents \
  --window-size=1400,900 --screenshot="$OUT" "$URL" >/dev/null 2>&1
echo "saved $OUT"
