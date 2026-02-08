-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override <leader>cd to also copy diagnostic to clipboard
vim.keymap.set("n", "<leader>cd", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diagnostics > 0 then
    local messages = {}
    for _, d in ipairs(diagnostics) do
      table.insert(messages, d.message)
    end
    vim.fn.setreg("+", table.concat(messages, "\n"))
  end
  vim.diagnostic.open_float()
end, { desc = "Line Diagnostics (copy to clipboard)" })
