#!/usr/bin/env bash
set -euo pipefail

cat >&2 <<'MSG'
The old install.sh was destructive and Linux-specific.

Use the safer revived setup entrypoint instead:

  ./setup.sh --all          # dry run
  ./setup.sh --all --apply  # apply symlinks/backups

For macOS music setup:

  ./setup.sh --music --install-packages --apply
MSG

exit 1
