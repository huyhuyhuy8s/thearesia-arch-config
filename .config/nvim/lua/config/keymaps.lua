-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>sx", function()
  local cached_pickers = require("telescope.state").get_global_key("cached_pickers")
  if cached_pickers == nil or vim.tbl_isempty(cached_pickers) then
    print("No search to resume!") -- Optional: friendly message instead of error
    return
  end
  require("telescope.builtin").resume()
end, { noremap = true, silent = true, desc = "Resume last search" })
