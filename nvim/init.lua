-- Automatically load Packer if installed
vim.cmd [[packadd packer.nvim]]

-- Initialize Packer
require('packer').startup(function(use)

-- You can list your plugins here.
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "folke/tokyonight.nvim", branch = "main" }
  use { "gruvbox-community/gruvbox" } 
-- Add other plugins here as needed.
end)


-- Enable true-color support
vim.o.termguicolors = true

-- Configure Catppuccin (choose your preferred flavor: "latte", "frappe", "macchiato", "mocha")
require("catppuccin").setup({
     custom_highlights = {
        Normal = { bg = "#000000" },
    },
    flavour = "mocha",
  -- additional configuration options can go here
})

-- Configure Tokyonight (choose your preferred style: "night", "storm", or "day")
require("tokyonight").setup({
  style = "storm",  -- You can change this to "storm" or "day"
  -- You can add additional options here if needed.
})

-- Set Catppuccin as the active colorscheme
vim.cmd("colorscheme catppuccin")



-- Enable Relative Line Numbers
vim.opt.relativenumber = true

-- Define a command to switch to Catppuccin:
vim.api.nvim_create_user_command("Catppuccin", function()
  vim.cmd("colorscheme catppuccin")
end, {})

-- Define a command to switch to Tokyonight:
vim.api.nvim_create_user_command("Tokyonight", function()
  vim.cmd("colorscheme tokyonight")
end, {})

-- Define a command to switch to Gruvbox:
vim.api.nvim_create_user_command("Gruvbox", function()
  vim.cmd("colorscheme gruvbox")
end, {})

-- Define a command to copy selected text
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- Map Ctrl+v in normal mode to paste from the system clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })

-- Map Ctrl+v in visual mode to paste from the system clipboard
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true })

