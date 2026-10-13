#!/bin/bash
set -e

# Variables
SDK="$HOME/Developer/PlaydateSDK"
PROJECT_NAME="test-game.pdx"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT="$PROJECT_DIR/build/$PROJECT_NAME"

# Command
if "$SDK/bin/pdc" "$PROJECT_DIR/source" "$OUTPUT"; then
  echo "Build completata:"
  echo "$OUTPUT"
  echo "Dimensione app: $(du -sh "$OUTPUT" | cut -f1)"
else
  echo "Build error" >&2
  exit 1
fi

# Open Playdate Simulator
if open -a "$SDK/bin/Playdate Simulator.app" "$OUTPUT"; then
  echo "Open Simulator"
else
  echo "Simulator error" >&2
  exit 1
fi
