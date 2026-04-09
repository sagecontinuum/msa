#!/usr/bin/env bash
# install.sh — First-time setup: create the virtualenv and install dependencies.
#
# Safe to re-run: skips venv creation if .venv already exists.
#
# Usage:
#   bin/install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "=== MSA Setup ==="
echo ""

if [[ ! -d ".venv" ]]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
    echo "Done."
else
    echo ".venv already exists — skipping creation."
fi

echo "Installing dependencies..."
source .venv/bin/activate
pip install -r requirements.txt

if [[ ! -f "scratchpad/active.yaml" ]]; then
    echo "Initializing scratchpad from config/active.reset.yaml..."
    cp config/active.reset.yaml scratchpad/active.yaml
    echo "Done."
fi

echo ""
echo "Setup complete. Next steps:"
echo ""
echo "  1. Edit config/active.reset.yaml to set your agent's goals"
echo "  2. Run bin/reset.sh to apply the template"
echo "  source .venv/bin/activate"
echo "  export ANTHROPIC_API_KEY=sk-ant-..."
echo "  bin/check-env.sh"
echo "  bin/run.sh"
