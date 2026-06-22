# Dotfiles

Personal terminal-environment config for machines that should feel familiar:
music, editor, file navigation, and other CLI workflows.

This repo is being revived in stages. The current v1 target is intentionally
small:

- macOS music playback with `mpd`, `ncmpcpp`, and local files under
  `/Users/sourya4/pro/youtube_download/music`
- baseline Neovim config, plus a minimal Vim fallback
- AI-enabled Neovim chat through CodeCompanion and Codex ACP
- ranger config with portable clipboard helpers

`ma08/botfiles` remains the home for coding-agent, orchestration, hooks, skills,
and automation bootstrap. This repo should own user-facing terminal app config.

## Quick Start

Preview everything first:

```bash
./setup.sh --all
```

Apply the current v1 config:

```bash
./setup.sh --all --apply
```

Install the macOS music packages and apply music config:

```bash
./setup.sh --music --install-packages --apply
```

Install packages for the full v1 profile and apply all current config:

```bash
./setup.sh --all --install-packages --apply
```

The setup script backs up existing non-matching files before replacing them with
symlinks. Without `--apply`, it only prints what it would do.

## Music

The macOS music profile installs or configures:

- `mpd`
- `mpc`
- `ncmpcpp`

Relevant paths:

- MPD config: `~/.mpd/mpd.conf`
- MPD music directory: `/Users/sourya4/pro/youtube_download/music`
- ncmpcpp config: `~/.ncmpcpp/config`
- ncmpcpp bindings: `~/.ncmpcpp/bindings`

Basic checks:

```bash
mpd --no-daemon ~/.mpd/mpd.conf
mpc update
ncmpcpp
```

Terminal playback is the v1 success gate. macOS media keys / Now Playing support
is a follow-up unless it becomes simple and reliable.

## Editor

Neovim is the primary editor target:

- `nvim/init.lua` -> `~/.config/nvim/init.lua`

With `--install-packages`, the editor profile installs `neovim` through
Homebrew, plus `node` for `npx`-backed ACP adapters.

The editor profile also sets Git's global editor to `nvim` and enables verbose
commit templates, so `git commit` opens Neovim with the staged diff available as
commented context.

Vim gets a minimal fallback:

- `vim/vimrc-basic` -> `~/.vimrc`

The old `vim/.vimrc` and Vim bundle submodules are historical material, not the
default install path for the revived setup.

### AI In Neovim

The Neovim config bootstraps `lazy.nvim`, installs CodeCompanion, and configures
the Codex ACP adapter with ChatGPT authentication. It runs the Zed Codex ACP
adapter through:

```bash
npx -y @zed-industries/codex-acp
```

Use `:CodeCompanionChat` inside Neovim to open an AI chat buffer. The first run
may download plugins and the ACP adapter. ChatGPT auth must be available through
Codex/Codex ACP on the machine; API-key and Azure OpenAI variants can be added
later without changing the base music/editor/ranger setup.

In `git commit` buffers, press `,cm` to draft a commit message from the verbose
commit buffer. Press `,cy` to accept CodeCompanion's proposed edit or `,cn` to
reject it.

## Ranger

The ranger profile links the repo's ranger config into `~/.config/ranger/` and
installs `bin/dotfiles-clipboard-copy` into `~/.local/bin/`. The clipboard helper
uses `pbcopy`, `wl-copy`, `xclip`, or `xsel`, depending on what the machine has.
With `--install-packages`, the ranger profile installs `ranger` through Homebrew.

## Historical Material

The old repo includes i3, polybar, Vimperator, X resources, old Linux desktop
scripts, and large Vim plugin submodule history. Those are preserved for now but
not installed by the default v1 setup. Audit and resurrect them only after an
explicit review.
