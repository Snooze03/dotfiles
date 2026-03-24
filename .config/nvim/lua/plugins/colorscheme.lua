return {
  -- Add the onedarkpro plugin
  {
    "olimorris/onedarkpro.nvim",
    enabled = false,
    priority = 1000, -- Ensure it loads first
  },
  {
    "neanias/everforest-nvim",
    priority = 1000,
    enabled = true,
    lazy = false,
    config = function()
      require("everforest").setup({
        -- "hard", "medium" (default), or "soft"
        background = "medium",
        transparent_background_level = 2,
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
