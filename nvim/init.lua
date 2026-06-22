vim.g.mapleader = ","

local opt = vim.opt

opt.encoding = "utf-8"
opt.number = true
opt.ruler = true
opt.showcmd = true
opt.hidden = true
opt.confirm = true
opt.autoread = true
opt.backspace = { "indent", "eol", "start" }
opt.mouse = "a"

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true

opt.splitbelow = true
opt.splitright = true
opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }
opt.timeoutlen = 400
opt.updatetime = 300

opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/state/nvim/undo//")

if vim.fn.has("clipboard") == 1 then
  opt.clipboard = "unnamedplus"
end

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { silent = true })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        acp = {
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = {
                auth_method = "chatgpt",
              },
              commands = {
                default = {
                  "npx",
                  "-y",
                  "@zed-industries/codex-acp",
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "codex",
        },
      },
    },
  },
})

