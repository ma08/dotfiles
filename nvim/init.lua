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
opt.laststatus = 2

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

local codecompanion_status = {
  active = 0,
  clear_timer = nil,
  frames = { "|", "/", "-", "\\" },
  message = "",
  spinner = 1,
  timer = nil,
}

local function codecompanion_request_label(data)
  local adapter = data and data.adapter or {}
  local name = adapter.formatted_name or adapter.name or "AI"
  local model = adapter.model

  if model and model ~= "" then
    return name .. " " .. model
  end

  return name
end

local function codecompanion_redraw_status()
  pcall(vim.cmd, "redrawstatus")
end

local function codecompanion_clear_later()
  if codecompanion_status.clear_timer then
    codecompanion_status.clear_timer:stop()
    codecompanion_status.clear_timer:close()
  end

  codecompanion_status.clear_timer = vim.uv.new_timer()
  codecompanion_status.clear_timer:start(
    2500,
    0,
    vim.schedule_wrap(function()
      codecompanion_status.message = ""
      codecompanion_redraw_status()
    end)
  )
end

local function codecompanion_start_spinner()
  if codecompanion_status.clear_timer then
    codecompanion_status.clear_timer:stop()
    codecompanion_status.clear_timer:close()
    codecompanion_status.clear_timer = nil
  end

  if codecompanion_status.timer then
    return
  end

  codecompanion_status.timer = vim.uv.new_timer()
  codecompanion_status.timer:start(
    0,
    120,
    vim.schedule_wrap(function()
      if codecompanion_status.active <= 0 then
        return
      end

      codecompanion_status.spinner = (codecompanion_status.spinner % #codecompanion_status.frames) + 1
      codecompanion_redraw_status()
    end)
  )
end

local function codecompanion_stop_spinner()
  if codecompanion_status.timer then
    codecompanion_status.timer:stop()
    codecompanion_status.timer:close()
    codecompanion_status.timer = nil
  end
  codecompanion_redraw_status()
end

function _G.CodeCompanionStatus()
  if codecompanion_status.active > 0 then
    return string.format(
      " AI %s %s",
      codecompanion_status.frames[codecompanion_status.spinner],
      codecompanion_status.message
    )
  end

  if codecompanion_status.message ~= "" then
    return " AI " .. codecompanion_status.message
  end

  return ""
end

opt.statusline = table.concat({
  "%f",
  "%m%r%h%w",
  "%=",
  "%{v:lua.CodeCompanionStatus()}",
  " %y",
  " %l:%c",
  " %P",
})

vim.api.nvim_create_autocmd("User", {
  pattern = {
    "CodeCompanionRequestStarted",
    "CodeCompanionRequestStreaming",
    "CodeCompanionRequestFinished",
  },
  group = vim.api.nvim_create_augroup("DotfilesCodeCompanionStatus", { clear = true }),
  callback = function(event)
    local data = event.data or {}

    if event.match == "CodeCompanionRequestStarted" then
      codecompanion_status.active = codecompanion_status.active + 1
      codecompanion_status.message = codecompanion_request_label(data)
      codecompanion_start_spinner()
      codecompanion_redraw_status()
      return
    end

    if event.match == "CodeCompanionRequestStreaming" then
      codecompanion_status.message = "streaming " .. codecompanion_request_label(data)
      codecompanion_redraw_status()
      return
    end

    codecompanion_status.active = math.max(0, codecompanion_status.active - 1)
    local status = data.status or "success"

    if status == "success" then
      codecompanion_status.message = "done"
    elseif status == "cancelled" or status == "canceled" then
      codecompanion_status.message = "cancelled"
    else
      codecompanion_status.message = "error"
      vim.notify("CodeCompanion request failed: " .. tostring(status), vim.log.levels.WARN)
    end

    if codecompanion_status.active == 0 then
      codecompanion_stop_spinner()
      codecompanion_clear_later()
    else
      codecompanion_redraw_status()
    end
  end,
})

vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<CR>", {
  desc = "CodeCompanion actions",
  silent = true,
})
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", {
  desc = "Toggle CodeCompanion chat",
  silent = true,
})
vim.keymap.set("v", "<leader>cA", "<cmd>CodeCompanionChat Add<CR>", {
  desc = "Add selection to CodeCompanion chat",
  silent = true,
})
vim.keymap.set({ "n", "v" }, "<leader>ci", ":CodeCompanion ", {
  desc = "CodeCompanion inline prompt",
  silent = false,
})
vim.keymap.set({ "n", "v" }, "<leader>cb", ":CodeCompanion #{buffer} ", {
  desc = "CodeCompanion inline prompt with buffer",
  silent = false,
})
vim.cmd([[cab cc CodeCompanion]])

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function(event)
    vim.keymap.set("n", "<leader>cm", function()
      local prompt = table.concat({
        "#{buffer}",
        "Draft a concise git commit message from the staged diff and status in this buffer.",
        "Insert it at the top above the commented lines.",
        "Use imperative mood.",
        "Include a short body only if it adds useful context.",
      }, " ")
      vim.cmd("normal! gg")
      vim.cmd("CodeCompanion " .. prompt)
    end, {
      buffer = event.buf,
      desc = "Draft git commit message",
      silent = true,
    })
  end,
})

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

local function azure_openai_v1_endpoint()
  local endpoint = vim.env.AZURE_OPENAI_ENDPOINT
  if endpoint and endpoint ~= "" then
    endpoint = endpoint:gsub("/+$", "")
    if not endpoint:match("/openai/v1$") then
      endpoint = endpoint .. "/openai/v1"
    end
    return endpoint
  end

  local ok, lines = pcall(vim.fn.readfile, vim.fn.expand("~/.codex/config.toml"))
  if not ok then
    return ""
  end

  local in_azure_provider = false
  for _, line in ipairs(lines) do
    if line:match("^%s*%[model_providers%.azure%]%s*$") then
      in_azure_provider = true
    elseif in_azure_provider and line:match("^%s*%[") then
      break
    elseif in_azure_provider then
      local base_url = line:match('^%s*base_url%s*=%s*"([^"]+)"')
      if base_url then
        return base_url:gsub("/+$", "")
      end
    end
  end

  return ""
end

require("lazy").setup({
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          azure_openai_gpt55 = function()
            return require("codecompanion.adapters").extend("openai_responses", {
              url = "${endpoint}/responses",
              env = {
                api_key = "AZURE_OPENAI_API_KEY",
                endpoint = azure_openai_v1_endpoint,
              },
              opts = {
                compaction = false,
                stream = false,
                tools = false,
                vision = true,
              },
              schema = {
                model = {
                  default = "gpt-5.5",
                  choices = {
                    ["gpt-5.5"] = {
                      formatted_name = "GPT-5.5",
                      meta = { context_window = 1050000 },
                      opts = {
                        can_reason = true,
                        has_function_calling = true,
                        has_vision = true,
                      },
                    },
                  },
                },
                ["reasoning.effort"] = {
                  default = "medium",
                },
                top_p = {
                  enabled = function()
                    return false
                  end,
                },
                max_output_tokens = {
                  default = 2048,
                },
                verbosity = {
                  default = "medium",
                },
              },
            })
          end,
        },
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
        inline = {
          adapter = "azure_openai_gpt55",
          keymaps = {
            stop = {
              modes = { n = "<leader>cs" },
            },
          },
        },
        shared = {
          keymaps = {
            view_diff = {
              modes = { n = "<leader>cd" },
            },
            accept_change = {
              modes = { n = "<leader>cy" },
            },
            reject_change = {
              modes = { n = "<leader>cn" },
            },
            always_accept = {
              modes = { n = "<leader>cY" },
            },
          },
        },
      },
    },
  },
})
