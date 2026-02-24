return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      style = 'night',
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = 'transparent',
        floats = 'transparent',
      },
    }

    vim.cmd [[colorscheme tokyonight-night]]

    local bg_transparent = true

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require('tokyonight').setup {
        transparent = bg_transparent,
        styles = {
          sidebars = bg_transparent and 'transparent' or 'dark',
          floats = bg_transparent and 'transparent' or 'dark',
        },
      }
      vim.cmd [[colorscheme tokyonight-night]]
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
