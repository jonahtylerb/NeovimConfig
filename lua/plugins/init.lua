require("nvim-treesitter.install").prefer_git = false
require("nvim-treesitter.install").compilers = { "clang" }
require("notify").setup({
  background_colour = "#000000",
})

return {
  {
    "marko-cerovac/material.nvim",
    event = "VeryLazy",
    opts = {
      lualine_style = "stealth",
      contrast = {
        terminal = true,
        sidebars = true,
        floating_windows = true,
        cursor_line = true,
      },
      disable = {
        background = true,
      },
    },
  },

  {
    "xiyaowong/nvim-transparent",
  },

  {
    "CantoroMC/ayu-nvim",
    event = "VeryLazy",
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "html",
        "svelte",
        "astro",
        "javascript",
        "css",
        "json",
        "markdown",
        "markdown_inline",
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "svelte-language-server",
        "shellcheck",
        "astro-language-server",
        "css-lsp",
        "emmet-ls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "prettierd",
        "shfmt",
        "stylua",
        "typescript-language-server",
        "unocss-language-server",
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = require("mini.indentscope").gen_animation.linear({ duration = 30, unit = "total" }),
      },
    },
  },

  {
    "folke/persistence.nvim",
    enabled = false,
  },

  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "T", require("ts-node-action").node_action, { desc = "Toggle ts-node-action" })
    end,
  },

  {
    "olimorris/persisted.nvim",
    event = "VeryLazy",
    config = function()
      require("persisted").setup()
      require("telescope").load_extension("persisted")
    end,
  },

  {
    "debugloop/telescope-undo.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>su", ":Telescope undo<cr>", { desc = "Undo" })
    end,
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      default_mappings = true,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower = 1000, upper = 1005, builtin = 1008, bookmark = 1020 },
    },
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        cursor = {
          enable = false,
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    event = "VeryLazy",
    config = function()
      require("refactoring").setup()
      require("telescope").load_extension("refactoring")
      vim.api.nvim_set_keymap(
        "v",
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true, desc = "Refactor" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rp",
        ":lua require('refactoring').debug.printf({below = false})<CR>",
        { noremap = true, desc = "Refactor Print" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rv",
        ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
        { noremap = true, desc = "Refactor Print Var" }
      )
      vim.api.nvim_set_keymap(
        "v",
        "<leader>rv",
        ":lua require('refactoring').debug.print_var({})<CR>",
        { noremap = true, desc = "Refactor Print Var" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rc",
        ":lua require('refactoring').debug.cleanup({})<CR>",
        { noremap = true, desc = "Refactor Cleanup" }
      )
    end,
  },

  {
    "tenxsoydev/karen-yank.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "ggandor/leap-spooky.nvim",
    event = "VeryLazy",
    opts = {
      paste_on_remote_yank = true,
    },
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    event = "VeryLazy",
  },

  { "echasnovski/mini.pairs", enabled = false },

  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    config = function()
      require("mini.align").setup()
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    config = function()
      require("mini.splitjoin").setup()
    end,
  },

  {
    "altermo/npairs-integrate-upair",
    dependencies = { "windwp/nvim-autopairs", "altermo/ultimate-autopair.nvim" },
    event = "VeryLazy",
    opts = {},
  },

  {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("i", "<tab>", vim.fn["codeium#Accept"], { expr = true })
      vim.keymap.set("i", "<c-down>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-up>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  {
    "echasnovski/mini.starter",
    version = false,
    event = "VimEnter",
    opts = function()
      local logo =
        "                                                 _.oo.          \n                         _.u[[/;:,.         .odMMMMMM'          \n                      .o888UU[[[/;:-.  .o@P^    MMM^            \n                     oN88888UU[[[/;::-.        dP^              \n███╗   ██╗███████╗  dNMMNN888UU[[[/;:--. ██╗.@P██╗██╗███╗   ███╗\n████╗  ██║██╔════╝ ,MMMMMMN888UU[[/;::-. ██║   ██║██║████╗ ████║\n██╔██╗ ██║█████╗   NNMMMNN888UU[[[/~.o@P^██║   ██║██║██╔████╔██║\n██║╚██╗██║██╔══╝   888888888UU[[[/o@^-.. ╚██╗ ██╔╝██║██║╚██╔╝██║\n██║ ╚████║███████╗oI8888UU[[[/o@P^:--..   ╚████╔╝ ██║██║ ╚═╝ ██║\n╚═╝  ╚═══╝╚══════╝  YUU[[[/o@^;::---..     ╚═══╝  ╚═╝╚═╝     ╚═╝\n             oMP     ^/o@P^;:::---..                            \n          .dMMM    .o@^ ^;::---...                              \n         dMMMMMMM@^`       `^^^^                                \n        YMMMUP^                                                 \n         ^^                                                     "
      local pad = string.rep(" ", 22)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")
    --stylua: ignore
    local config = {
      evaluate_single = true,
      header = logo,
      items = {
        new_section("Find file",    "Telescope find_files", "Telescope"),
        new_section("Recent files", "Telescope oldfiles",   "Telescope"),
        new_section("Open Session", "Telescope persisted", "Telescope"),
        new_section("Grep text",    "Telescope live_grep",  "Telescope"),
        new_section("init.lua",     "e $MYVIMRC",           "Config"),
        new_section("Lazy",         "Lazy",                 "Config"),
        new_section("New file",     "ene | startinsert",    "Built-in"),
        new_section("Quit",         "qa",                   "Built-in"),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(pad .. "░ ", false),
        starter.gen_hook.aligning("center", "center"),
      },
    }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer
            .. "⚡ Neovim loaded "
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms\n                 Whoa that Vim is fast!"
          pcall(starter.refresh)
        end,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_b = { "branch" },
        lualine_c = { "diagnostics" },
      },
    },
  },

  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    opts = {
      autostart = true,
      cursor = "",
      texthl = "SmoothCursor",
      linehl = "Cursorline",
      type = "default",
      fancy = {
        enable = true,
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
        body = {
          { cursor = "", texthl = "SmoothCursorRed" },
          { cursor = "•", texthl = "SmoothCursorOrange" },
          { cursor = "•", texthl = "SmoothCursorOrange" },
          { cursor = ".", texthl = "SmoothCursorYellow" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      speed = 50,
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Leader>td", ':TermExec cmd="pnpm dev" open=0<cr>', opts)
      vim.keymap.set("n", "<Leader>th", ':TermExec cmd="pnpm dev --host" open=0<cr>', opts)
      vim.keymap.set("n", "<Leader>tb", ':TermExec cmd="pnpm build"<cr>', opts)
      vim.keymap.set("n", "<Leader>tp", ':TermExec cmd="pnpm preview" open=0<cr>', opts)
      return {
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = -100,
        persist_mode = true,
        direction = "float",
        auto_scroll = true,
        float_opts = {
          border = "curved",
        },
      }
    end,
  },
}
