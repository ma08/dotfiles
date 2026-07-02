#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPLY=0
INSTALL_PACKAGES=0
DO_MUSIC=0
DO_EDITOR=0
DO_RANGER=0
DO_GIT=0

usage() {
  cat <<'USAGE'
Usage: ./setup.sh [--all] [--music] [--editor] [--ranger] [--git] [--install-packages] [--apply]

By default this is a dry run. Pass --apply to make changes.

Profiles:
  --music            Configure mpd/ncmpcpp
  --editor           Configure Neovim and Vim fallback
  --ranger           Configure ranger and clipboard helper
  --git              Configure Git terminal tools
  --all              Configure all current v1 profiles

Options:
  --install-packages Install Homebrew packages needed by selected profiles
  --apply            Make changes; otherwise only print actions
  -h, --help         Show this help
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --all)
      DO_MUSIC=1
      DO_EDITOR=1
      DO_RANGER=1
      DO_GIT=1
      ;;
    --music) DO_MUSIC=1 ;;
    --editor) DO_EDITOR=1 ;;
    --ranger) DO_RANGER=1 ;;
    --git) DO_GIT=1 ;;
    --install-packages) INSTALL_PACKAGES=1 ;;
    --apply) APPLY=1 ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [ "$DO_MUSIC$DO_EDITOR$DO_RANGER$DO_GIT" = "0000" ]; then
  usage >&2
  exit 2
fi

log() {
  printf '%s\n' "$*"
}

run() {
  if [ "$APPLY" -eq 1 ]; then
    "$@"
  else
    printf '[dry-run] '
    printf '%q ' "$@"
    printf '\n'
  fi
}

timestamp() {
  date +%Y%m%d%H%M%S
}

backup_path() {
  local path="$1"
  if [ -e "$path" ] || [ -L "$path" ]; then
    run mv "$path" "${path}.dotfiles-backup.$(timestamp)"
  fi
}

ensure_dir() {
  run mkdir -p "$1"
}

touch_file() {
  if [ ! -e "$1" ]; then
    run touch "$1"
  fi
}

link_path() {
  local source="$1"
  local dest="$2"

  if [ ! -e "$source" ] && [ ! -L "$source" ]; then
    echo "ERROR: source does not exist: $source" >&2
    exit 1
  fi

  ensure_dir "$(dirname "$dest")"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$source" ]; then
    log "already linked: $dest -> $source"
    return
  fi

  backup_path "$dest"
  run ln -s "$source" "$dest"
}

brew_bin() {
  if command -v brew >/dev/null 2>&1; then
    command -v brew
  elif [ -x /opt/homebrew/bin/brew ]; then
    printf '%s\n' /opt/homebrew/bin/brew
  elif [ -x /usr/local/bin/brew ]; then
    printf '%s\n' /usr/local/bin/brew
  else
    return 1
  fi
}

install_brew_packages() {
  local brew
  if [ "$APPLY" -eq 0 ]; then
    run brew install "$@"
    return
  fi

  brew="$(brew_bin)" || {
    echo "ERROR: Homebrew not found; install packages manually or rerun without --install-packages" >&2
    exit 1
  }
  run "$brew" install "$@"
}

install_brew_casks() {
  local brew
  if [ "$APPLY" -eq 0 ]; then
    run brew install --cask "$@"
    return
  fi

  brew="$(brew_bin)" || {
    echo "ERROR: Homebrew not found; install casks manually or rerun without --install-packages" >&2
    exit 1
  }
  run "$brew" install --cask "$@"
}

setup_music() {
  log "== music =="

  if [ "$INSTALL_PACKAGES" -eq 1 ]; then
    install_brew_packages mpd mpc ncmpcpp
    install_brew_casks hammerspoon
  fi

  ensure_dir "$HOME/.mpd/playlists"
  touch_file "$HOME/.mpd/database"
  touch_file "$HOME/.mpd/log"
  touch_file "$HOME/.mpd/pid"
  touch_file "$HOME/.mpd/state"
  touch_file "$HOME/.mpd/sticker.sql"
  ensure_dir "$HOME/.ncmpcpp"

  link_path "$ROOT/bin/dotfiles-mpd-restart" "$HOME/.local/bin/dotfiles-mpd-restart"
  link_path "$ROOT/mpd/mpd-macos.conf" "$HOME/.mpd/mpd.conf"
  link_path "$ROOT/ncmpcpp/config-macos" "$HOME/.ncmpcpp/config"
  link_path "$ROOT/ncmpcpp/bindings" "$HOME/.ncmpcpp/bindings"
  link_path "$ROOT/hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"
}

setup_editor() {
  log "== editor =="
  if [ "$INSTALL_PACKAGES" -eq 1 ]; then
    local packages=()
    command -v nvim >/dev/null 2>&1 || packages+=(neovim)
    command -v npx >/dev/null 2>&1 || packages+=(node)
    if [ "${#packages[@]}" -gt 0 ]; then
      install_brew_packages "${packages[@]}"
    fi
  fi

  ensure_dir "$HOME/.local/state/nvim/undo"
  if [ -e "$HOME/.config/nvim/init.vim" ] || [ -L "$HOME/.config/nvim/init.vim" ]; then
    backup_path "$HOME/.config/nvim/init.vim"
  fi
  link_path "$ROOT/nvim/init.lua" "$HOME/.config/nvim/init.lua"
  link_path "$ROOT/vim/vimrc-basic" "$HOME/.vimrc"

  run git config --global core.editor nvim
  run git config --global commit.verbose true
  run git config --global commit.status true
}

setup_ranger() {
  log "== ranger =="
  if [ "$INSTALL_PACKAGES" -eq 1 ]; then
    install_brew_packages ranger
  fi

  link_path "$ROOT/bin/dotfiles-clipboard-copy" "$HOME/.local/bin/dotfiles-clipboard-copy"
  link_path "$ROOT/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
  link_path "$ROOT/ranger/rifle.conf" "$HOME/.config/ranger/rifle.conf"
  link_path "$ROOT/ranger/commands.py" "$HOME/.config/ranger/commands.py"
  link_path "$ROOT/ranger/scope.sh" "$HOME/.config/ranger/scope.sh"
  link_path "$ROOT/ranger/colorschemes" "$HOME/.config/ranger/colorschemes"
}

setup_git_tools() {
  log "== git tools =="
  if [ "$INSTALL_PACKAGES" -eq 1 ]; then
    command -v gitui >/dev/null 2>&1 || install_brew_packages gitui
  fi

  if [ -x /opt/homebrew/bin/gitui ] || [ -x /home/linuxbrew/.linuxbrew/bin/gitui ]; then
    link_path "$ROOT/bin/dotfiles-gitui" "$HOME/.local/bin/gitui"
  fi

  link_path "$ROOT/config/gitui/key_bindings.ron" "$HOME/.config/gitui/key_bindings.ron"
}

if [ "$APPLY" -eq 0 ]; then
  log "Dry run only. Re-run with --apply to make changes."
fi

[ "$DO_MUSIC" -eq 1 ] && setup_music
[ "$DO_EDITOR" -eq 1 ] && setup_editor
[ "$DO_RANGER" -eq 1 ] && setup_ranger
[ "$DO_GIT" -eq 1 ] && setup_git_tools

log "Done."
