return {
  "crnvl96/lazydocker.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    { "<leader>ld", function() require("lazydocker").toggle() end, desc = "LazyDocker" },
  },
}
