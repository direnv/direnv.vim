#!/usr/bin/env bash
set -euo pipefail
version=${1:-$DIRENV_VERSION}
target=$HOME/bin

echo "Installing direnv v${version} to ${target}"

mkdir -p $HOME/bin
curl -sfL https://github.com/direnv/direnv/releases/download/v${version}/direnv.linux-amd64 > $HOME/bin/direnv
chmod +x $HOME/bin/direnv
