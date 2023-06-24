-- basic settings---------------------------
vim.opt.encoding='utf8'
vim.wo.number=true
vim.o.ruler=true
vim.wo.cursorline=true
vim.wo.cursorcolumn=true
vim.bo.expandtab=true
vim.bo.tabstop=2
vim.bo.shiftwidth=2
vim.bo.autoindent=true
--End basic settings-----------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)

--Color Settings--------------------------
vim.cmd('syntax on')

if vim.fn.has('termguicolors') then
  vim.opt.termguicolors=true
end
--End Color Settings----------------------
