
-- Definir el leader

vim.g.mapleader = " " -- Define el Espacio como la tecla Leader
vim.g.maplocalleader = " "


-- 1. Configuración básica de Lazy.nvim (El instalador)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- última versión estable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Aquí es donde añadiremos los plugins más adelante
require("lazy").setup({
	spec = {
	-- 1. Tema de colores (relajante)
--	{"catppuccin/nvim", name = "catppuccin", priority = 1000 },
-- 1. Temas de colores (Añadidos aquí para que Lazy los gestione)
    {"catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "sainnhe/everforest" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "shaunsingh/nord.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" }, -- Para el tema Sunset

  -- Plugin para transparencia (opcional, para ver el fondo con blur)
    { "xiyaowong/transparent.nvim" },
	-- 2. explorador de archivos
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- 3. Buscador (Telescope)
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	
	-- 4. barra de estado
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- 5. LSP (Configuración fácil para Python y otros)
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },		-- Instalador de servidores LSP
	{ "williamboman/mason-lspconfig.nvim" }, --Puente entre mason y lspconfig
	{ import = "plugins" },
	},

})
--	require('lspconfig').bashls.setup{}


	-- Activar Mason (el instalador de servicios de lenguaje)

	require("mason").setup()
	require("mason-lspconfig").setup({
	    ensure_installed = { "pyright", "bashls" },
		handlers = {
			-- esta es la forma moderna: Mason llamará a lspconfig internamente
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		},
})

-- LUEGO activas los servidores con lspconfig
local lspconfig = require('lspconfig')
--vim.lsp.config
--vim.lsp.enable()
-- Usamos el objeto lspconfig directamente
--lspconfig['pyright'].setup({})
-- lspconfig['bashls'].setup({})

-- lspconfig.pyright.setup{}  -- Activa Python Versions antiguas
--lspconfig.bashls.setup{}   -- Activa Bash (¡Aquí es donde va!)
-- tal vez podríamos borrar esta nvim-tree porque esta repetido
	require("nvim-tree").setup({
	  renderer = {
	    icons = {
	      show = {
		file = true,
		folder = true,
		git = true,
	      }
	     }
	   }
	})

	-- Activar True color
	vim.opt.termguicolors = true
	
	-- Configuraciones de plugins --
	-- Activar tema
--	vim.cmd.colorscheme "catppuccin-mocha"
	require('colores')
	-- Configurar lualine (Barra de abajo)
require('lualine').setup({
  options = {
    theme = 'auto', -- Mantiene la estética de tu tema
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'}, -- Aquí verás tus errores e ideas
    lualine_c = {'filename'},
    lualine_x = {}, -- Borramos lo que suele ir aquí (tipo de archivo)
    lualine_y = {}, -- Borramos el porcentaje de progreso
    lualine_z = {
      function()
        return "" -- Este es el icono del pingüino (Tux)
      end
    }
  }
})

	-- Configurar Nvim-Tree
--	require("nvim-tree").setup()

	-- Configuración de teclas (keymaps) --
	local keymap = vim.keymap -- para abreviar

	-- Atajos para NvimTree (explorador)
	keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Abrir/Cerrar explorador' })

	-- Atajos para moverte entre ventanas del nvimtree
	-- Ctrl + i (izquierda), Ctrl + d (derecha)
	keymap.set('n', '<C-i>', '<C-w>h')
	keymap.set('n', '<C-d>', '<C-w>l')

	-- Atajos para Telescope (Buscador)
	local builtin = require('telescope.builtin')
	keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Buscar archivos
	keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- Buscar texto dentro de archivos

	
  -- Moverse entre buffers
  -- Moverse al archivo anterior (izquierda)
vim.keymap.set('n', '<C-1>', ':bprevious<CR>', { desc = 'Archivo anterior' })

-- Moverse al archivo siguiente (derecha)
vim.keymap.set('n', '<C-2>', ':bnext<CR>', { desc = 'Archivo siguiente' })

-- Mirar lista de buffers
vim.keymap.set('n', '<C-3>', ':ls<CR>', { desc = 'Lista de archivos' })

-- Cerrar buffer actual
vim.keymap.set('n', '<C-4>', ':bd<CR>', { desc = 'Cerrararchivo' })

-- lista de buffers  c + 0
--vim.keymap.set('n', '<leader>2', ':ls<CR>', { desc = 'Lista de buffers' })
-- lista de buffers  c + 0
--vim.keymap.set('n', '<leader>3', ':buffer 3<CR>', { desc = 'fers' })



-- Mapear buffers
--for i = 1, 9 do
--  vim.keymap.set('n', '<C-' .. i .. '>', ':buffer ' .. i .. '<CR>', { desc = 'Ir al buffer ' .. i })
--end
--
-- 3. Tus opciones personales (Lo que vimos antes)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Función para ejecutar el archivo según su tipo
local function ejecutar_archivo()
	vim.cmd("silent w") -- siempre guarda antes de ejecutar
	local ft = vim.bo.filetype -- detecta el tipo de archivo (python, sh, etc.)
--	print("\n--- Ejecutando " .. ft .. " ---\n") -- separador visual limpio
	if ft == "python" then
		vim.cmd("!python3 %")
	elseif ft == "sh" then
		vim.cmd("!bash %")
	else
		print("No hay comando de ejecución para: " .. ft)
	end
end

	-- Mapeamos f5 a nuestra nueva función
	vim.keymap.set('n', '<F5>', ejecutar_archivo, { desc = 'Ejecutar script (Python/Bash)' })

	-- copiar al portapapeles
	vim.opt.clipboard = "unnamedplus"


-- Guardar automáticamente al perder el foco o salir del modo insertar
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, { --InsertLeave
  callback = function()
    if vim.bo.modified and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! update")
    end
  end,
})

-- CONFIGURACIÓN DE TELESCOPE --
local telescope = require('telescope')
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

telescope.setup({
  defaults = {
    -- Ignorar carpetas pesadas y binarios para que sea rápido
    file_ignore_patterns = { "node_modules", ".var", ".local", ".cargo", ".git/", "%.jpg", ".config/google-chrome/", ".config/GIMP", ".themes", "%.png", "%.jpeg", ".cache/" },
    mappings = {
      i = {
        ["<CR>"] = function(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          local filename = entry.path or entry.value
          -- Si es imagen, abrir con feh y cerrar telescope
          if filename:match("%.jpg$") or filename:match("%.png$") or filename:match("%.jpeg$") then
            actions.close(prompt_bufnr)
            os.execute("feh " .. filename .. " &")
          else
            actions.select_default(prompt_bufnr)
          end
        end,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true, -- Mostrar archivos ocultos (.bashrc, .config, etc.)
    },
  },
})

vim.opt.cursorline = true -- resalta la linea donde está el cursor
vim.opt.termguicolors = true -- asegura colores reales de 24 bits.
