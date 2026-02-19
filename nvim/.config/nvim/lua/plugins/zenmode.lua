return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  config = function()
    require("zen-mode").setup({
      plugins = {
        twilight = { enabled = true },
      },
    })
    
    -- El atajo dentro del config para que solo exista si el plugin está
    vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Alternar modo Zen" })
  end
}
