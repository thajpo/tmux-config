return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = { input = {}, picker = {}, terminal = {} },
    },
  },
  keys = {
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      desc = "Ask opencode",
      mode = { "n", "x" },
    },
    {
      "<leader>os",
      function()
        require("opencode").select()
      end,
      desc = "Select opencode action",
    },
    {
      "<leader>ot",
      function()
        require("opencode").toggle()
      end,
      desc = "Toggle opencode",
    },
  },
  config = function()
    vim.g.opencode_opts = vim.g.opencode_opts or {}
    vim.o.autoread = true
  end,
}
