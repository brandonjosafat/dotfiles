return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {},
  config = function(_, opts)
    require('render-markdown').setup(opts)
    -- Atajo: Espacio + m (de Markdown) para activar/desactivar
    vim.keymap.set('n', '<leader>m', ':RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown Render' })
  end
}
