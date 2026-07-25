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
- Git terminal tools such as `gitui`

`ma08/botfiles` remains the home for coding-agent, orchestration, hooks, skills,
secrets-aware shell bootstrap, and agent-specific aliases. This repo owns
general human terminal UX: shell ergonomics, editors, music, file navigation,
Git terminal tools, and user-facing app config. Botfiles can extend this
environment for agent workflows, but should not replace it as the general
dotfiles layer.

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

Install Git terminal tools:

```bash
./setup.sh --git --install-packages --apply
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
- MPD CoreAudio restart helper: `~/.local/bin/dotfiles-mpd-restart`

Basic checks:

```bash
mpd --no-daemon ~/.mpd/mpd.conf
mpc update
ncmpcpp
```

Hammerspoon watches for macOS audio output changes and runs the MPD restart
helper when MPD is already running. This works around stale CoreAudio device
handles after plugging, unplugging, or switching output devices.

Hammerspoon also maps macOS media keys to MPD for play/pause, next, and
previous. To avoid stealing media keys from Chrome or other players, it only
handles them when MPD is already playing, or when MPD is paused and the
frontmost app is not a known media app such as Chrome, Safari, Spotify, Music,
VLC, or IINA.

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
Codex/Codex ACP on the machine.

Inline edits use Gemini 3.6 Flash through CodeCompanion's Gemini HTTP adapter.
Set `GEMINI_API_KEY` in the machine-local botfiles secrets loaded by `.botenv`;
do not place it in this repository. The adapter is intentionally non-streaming
because CodeCompanion's Gemini inline handler requires a complete response. It
uses Gemini's `minimal` thinking level to keep inline edits responsive.

In `git commit` buffers, press `,cm` to draft a commit message from the verbose
commit buffer. Press `,cy` to accept CodeCompanion's proposed edit or `,cn` to
reject it.

While CodeCompanion is waiting on a chat or inline request, the statusline shows
an `AI` spinner with the active adapter/model. It briefly changes to `AI done`,
`AI cancelled`, or `AI error` when the request finishes.

## Ranger

The ranger profile links the repo's ranger config into `~/.config/ranger/` and
installs `bin/dotfiles-clipboard-copy` into `~/.local/bin/`. The clipboard helper
uses `pbcopy`, `wl-copy`, `xclip`, or `xsel`, depending on what the machine has.
With `--install-packages`, the ranger profile installs `ranger` through Homebrew.

## Git Tools

The Git tools profile installs `gitui` through Homebrew/Linuxbrew. GitUI config
uses vim-style navigation through:

- `config/gitui/key_bindings.ron` -> `~/.config/gitui/key_bindings.ron`

The setup also links `bin/dotfiles-gitui` to `~/.local/bin/gitui` on machines
where GitUI is installed by Homebrew/Linuxbrew. Keeping config under
`config/gitui/` avoids a zsh `AUTO_CD` collision with the `gitui` command.

## Historical Material

The old repo includes i3, polybar, Vimperator, X resources, old Linux desktop
scripts, and large Vim plugin submodule history. Those are preserved for now but
not installed by the default v1 setup. Audit and resurrect them only after an
explicit review.
