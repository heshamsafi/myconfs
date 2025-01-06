require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"


--- hhamed
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99 -- disable folds on start

vim.api.nvim_set_keymap('n', '<leader>lf', ":lua require('telescope.builtin').live_grep({ additional_args = function() return { '-F' } end })<CR>", { noremap = true, silent = true })

-- Add keybinding for live_grep_args
vim.api.nvim_set_keymap('n', '<leader>lg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { noremap = true, silent = true })

local map = vim.keymap.set
local telescope = require('telescope.builtin')

map('n', '<leader>z', function()
  telescope.buffers({ sort_mru = true, ignore_current_buffer = true })
end)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*", -- Apply to all file types
  callback = function()
    local save_cursor = vim.fn.getpos(".") -- Save cursor position
    vim.cmd([[%s/\s\+$//e]]) -- Remove trailing spaces
    vim.fn.setpos(".", save_cursor) -- Restore cursor position
  end,
})
