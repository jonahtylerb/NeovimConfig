return {
  {
    "jghauser/kitty-runner.nvim",
    event = "VeryLazy",
    config = function()
      require("kitty-runner").setup()
    end,
  },

  {
    "edluffy/hologram.nvim",
    event = "VeryLazy",
    opts = {
      config = {
        auto_display = true,
      },
    },
  },
}
