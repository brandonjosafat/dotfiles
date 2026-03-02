-- return {
--   'MeanderingProgrammer/render-markdown.nvim',
--   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
--   opts = {
--  heading = {
--             -- Esto hará que los encabezados usen los colores de nivel de tu tema
--             hl_groups = {
--                 '@text.title.1.markdown',
--                 '@text.title.2.markdown',
--                 '@text.title.3.markdown',
--                 '@text.title.4.markdown',
--             },
--         },
-- 	},
--
--
--
--   config = function(_, opts)
--     require('render-markdown').setup(opts)
--     -- Atajo: Espacio + m (de Markdown) para activar/desactivar
--     vim.keymap.set('n', '<leader>m', ':RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown Render' })
--   end
--
--   }

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    heading = {
      -- Desactivamos los fondos de colores sólidos para evitar fatiga visual
      backgrounds = {},
      -- Enlazamos los niveles a grupos de colores estándar de Neovim
      hl_groups = {
        'Identifier', -- H1 (Usualmente el color de acento/naranja en Nord)
        'Statement',  -- H2
        'Type',       -- H3
        'Special',    -- H4
      },
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)
    
    -- Atajo: Espacio + m para activar/desactivar
    vim.keymap.set('n', '<leader>m', ':RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown Render' })
    
    -- TRUCO PARA NORD: Forzar colores si el tema no los da
    -- Esto asegura que se vean bien incluso con transparencia
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { link = 'Identifier', default = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { link = 'Statement', default = true })
  end
}

