return {
  {
    "letieu/hacker.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function()
      vim.keymap.set(
        "n",
        "<leader><cr>",
        ":CellularAutomaton make_it_rain<CR>",
        { desc = "Make it rain!", noremap = true, silent = true }
      )
    end,
  },
}
