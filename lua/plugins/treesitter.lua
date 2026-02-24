return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()

    -- Ensure these parsers are installed (runs async after startup)
    local ensure_installed = {
      'lua', 'python', 'javascript', 'typescript', 'vimdoc', 'vim',
      'regex', 'terraform', 'sql', 'dockerfile', 'toml', 'json',
      'java', 'groovy', 'go', 'gitignore', 'graphql', 'yaml',
      'make', 'cmake', 'markdown', 'markdown_inline', 'bash',
      'tsx', 'css', 'html',
    }

    vim.defer_fn(function()
      local installed = require('nvim-treesitter').get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)
      if #to_install > 0 then
        vim.cmd('silent TSInstall ' .. table.concat(to_install, ' '))
      end
    end, 100)

    -- Enable treesitter-based indentation
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
