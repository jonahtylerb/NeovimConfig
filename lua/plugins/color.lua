return {
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
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
        enabled = true,
        lsp = true,
      },
      recognize = {
        input = true,
      },
    },
  },
}
