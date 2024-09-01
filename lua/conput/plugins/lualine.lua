return {
  "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('lualine').setup {
      -- options = {
      --   icons_enabled = true,
      --   theme = 'auto',
      --   component_separators = { left = '', right = ''},
      --   section_separators = { left = '', right = ''},
      --   disabled_filetypes = {},
      --   always_divide_middle = true,
      -- },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            function()
              local path = vim.fn.expand('%:p')
              local cwd = vim.fn.getcwd()
              local relative_path = vim.fn.fnamemodify(path, ':~:.')
              local readonly = vim.bo.readonly and " 󰌾 " or ""
              local modified = vim.bo.modified and "" or ""

              -- Highlight groups
              local directory_hl = ""
              local filename_hl = "%#Bold#"
              local modified_hl = "%#MatchParen#"

              -- Split the path into directory and filename
              local dir, file = string.match(relative_path, "(.*/)(.*)")
              if not dir then
                dir = ""
                file = relative_path
              end

              -- Apply highlighting
              local result = directory_hl .. dir .. filename_hl .. file

              -- Add modified and readonly indicators
              if modified ~= "" then
                result = result .. modified_hl .. modified
              end
              if readonly ~= "" then
                result = result .. readonly
              end

              return result
            end,
            color = { gui = 'bold' }
          }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    }
  end
}


