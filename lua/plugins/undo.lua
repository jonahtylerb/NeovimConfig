return {
  {
    "tzachar/highlight-undo.nvim",
    event = "BufReadPre",
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
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>su", ":Telescope undo<cr>", { desc = "Undo" })
    end,
  },
}
