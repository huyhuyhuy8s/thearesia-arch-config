return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<leader>s0",
      ":Telescope file_browser path=%:p:h=%:p:h<cr>",
      desc = "Browser Files",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
