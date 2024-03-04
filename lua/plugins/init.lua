return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      top_down = false,
    },
  },

  {
    "mawkler/modicator.nvim",
    dependencies = "CantoroMC/ayu-nvim",
    event = "VeryLazy",
    opts = function()
      vim.o.cursorline = true
      vim.o.number = true
      return {}
    end,
  },

  {
    "nullchilly/fsread.nvim",
    cmd = "FSRead",
  },

  {
    "cpea2506/relative-toggle.nvim",
    event = "VeryLazy",
  },

  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    keys = "<leader>T",
    config = function()
      vim.keymap.set("n", "<leader>T", require("ts-node-action").node_action, { desc = "Toggle ts-node-action" })
    end,
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
    opts = {},
    config = function()
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
    config = true,
  },

  {
    "AckslD/muren.nvim",
    cmd = "MurenOpen",
    config = true,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = true,
  },

  { "echasnovski/mini.pairs", enabled = false },

  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {},
  },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
          "./snippets/snippet.json",
          "./snippets/context.jsx.json",
          "./snippets/context.tsx.json",
          "./snippets/JSX.jsx.tsx.json",
          "./snippets/reactivity.json",
        },
      })
      return {}
    end,
  },

  {
    "Dhanus3133/LeetBuddy.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("leetbuddy").setup({
        language = "ts",
      })
    end,
    keys = {
      { "<leader>lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
      { "<leader>ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
      { "<leader>lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
      { "<leader>lt", "<cmd>LBTest<cr>", desc = "Run Code" },
      { "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = function()
      local slow_format_filetypes = {}
      require("conform").setup({
        format_on_save = function(bufnr)
          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          local function on_format(err)
            if err and err:match("timeout$") then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 200, lsp_fallback = true }, on_format
        end,

        format_after_save = function(bufnr)
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { lsp_fallback = true }
        end,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "jcha0713/cmp-tw2css" },
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end
          return item
        end,
      }

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "cmp-tw2css" } }))
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
        new_section("Open Project", "Telescope projects","Telescope"),
        new_section("Grep text",    "Telescope live_grep",  "Telescope"),
        new_section("init.lua",     "e $MYVIMRC",           "Config"),
        new_section("Lazy",         "Lazy",                 "Config"),
        new_section("New file",     "ene | startinsert",    "Built-in"),
        new_section("Quit",         "qa",                   "Built-in"),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(pad .. " ", false),
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
        head = { cursor = ">", texthl = "SmoothCursor", linehl = nil },
        body = {
          { cursor = "•", texthl = "SmoothCursorRed" },
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
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Leader>td", ':TermExec cmd="bun dev" open=0<cr>', opts)
      vim.keymap.set("n", "<Leader>th", ':TermExec cmd="bun dev --host" open=0<cr>', opts)
      vim.keymap.set("n", "<Leader>tb", ':TermExec cmd="bun build"<cr>', opts)
      vim.keymap.set("n", "<Leader>tp", ':TermExec cmd="bun preview" open=0<cr>', opts)
      vim.keymap.set("n", "<Leader>tn", ':TermExec cmd="netlify dev" open=0<cr>', opts)
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

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    priority = 1000,
    event = "VimEnter",
  },

  {
    "uga-rosa/ccc.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>cc",
        ":CccPick<CR>",
        { desc = "CCC Color Picker" },
      },
      {
        "<leader>cv",
        ":CccConvert<CR>",
        { desc = "CCD Color Converter" },
      },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      recognize = {
        input = true,
      },
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
        "css",
        "json",
        "markdown",
        "markdown_inline",
        "vue",
      })
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
      ft_to_parser.mdx = "markdown"
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
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "prettierd",
        "eslint_d",
        "shfmt",
        "stylua",
        "typescript-language-server",
        "unocss-language-server",
        "vue-language-server",
      },
    },
  },

  {
    "letieu/hacker.nvim",
    cmd = "HackFollow",
    keys = {
      {
        "<leader>h",
        ":HackFollow<CR>",
        { noremap = true, desc = "Hacker" },
      },
    },
  },

  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader><cr>",
        ":CellularAutomaton make_it_rain<CR>",
        { desc = "Make it rain!", noremap = true, silent = true },
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
    "chrisgrieser/nvim-genghis",
    dependencies = "stevearc/dressing.nvim",
    keys = function()
      local genghis = require("genghis")
      return {
        {
          "<leader>fr",
          genghis.renameFile,
          desc = "Rename File",
        },
        {
          "<leader>fm",
          genghis.moveAndRenameFile,
          desc = "Move And Rename File",
        },
        {
          "<leader>fn",
          genghis.createNewFile,
          desc = "Create New File",
        },
        {
          "<leader>fp",
          genghis.duplicateFile,
          desc = "Duplicate File",
        },
      }
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      mapping = {
        "jk",
        "kj",
      },
    },
  },

  {
    "jghauser/kitty-runner.nvim",
    cmd = "KittyOpenRunner",
    config = true,
  },

  {
    "samodostal/image.nvim",
    event = "VeryLazy",
    opts = {
      render = {
        min_padding = 5,
        show_label = true,
        show_image_dimensions = true,
        use_dither = true,
        foreground_color = true,
        background_color = true,
      },
      events = {
        update_on_nvim_resize = true,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").set_icon({
        astro = {
          icon = "",
          color = "#ff5d01",
          name = "astro",
        },
      })
    end,
  },

  {
    "tzachar/highlight-undo.nvim",
    keys = {
      "u",
      "<C-r>",
    },
    opts = {
      hlgroup = "HighlightUndo",
      duration = 300,
      keymaps = {
        { "n", "u", "undo", {} },
        { "n", "<C-r>", "redo", {} },
      },
    },
  },

  {
    "debugloop/telescope-undo.nvim",
    keys = {
      "<leader>su",
    },
    config = function()
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>su", ":Telescope undo<cr>", { desc = "Undo" })
    end,
  },

  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    opts = {
      filetypes = {
        "html",
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "python",
        "astro",
        "vue",
        "svelte",
      },
      jsx_brackets = true,
      remove_template_string = true,
    },
  },

  { "echasnovski/mini.operators", config = true, event = "VeryLazy" },

  {
    "piersolenski/telescope-import.nvim",
    keys = {
      {

        "<leader>si",
        ":Telescope import<cr>",
        desc = "Import",
      },
    },
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    opts = {},
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>sp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },

  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
  },

  {
    "sontungexpt/buffer-closer",
    event = "VeryLazy",
    config = true,
  },
  {
    "https://git.sr.ht/~swaits/thethethe.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    cmd = "Tardis",
  },
  {
    "NStefan002/visual-surround.nvim",
    event = "VeryLazy",
    config = function()
      require("visual-surround").setup({})
    end,
  },

  {
    "S1M0N38/love2d.nvim",
    cmd = "LoveRun",
    opts = {
      path_to_love_bin = "/usr/bin/love",
      restart_on_save = true,
    },
    keys = {
      { "<leader>v", desc = "LÖVE" },
      { "<leader>vv", "<cmd>LoveRun<cr>", desc = "Run LÖVE" },
      { "<leader>vs", "<cmd>LoveStop<cr>", desc = "Stop LÖVE" },
    },
  },
}
