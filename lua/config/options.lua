-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.timeoutlen = 500
vim.fn.sign_define("LspDiagnosticsSignError", { text = " ", texthl = "LspDiagnosticsSignError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = " ", texthl = "LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = " ", texthl = "LspDiagnosticsSignInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "󱠂", texthl = "LspDiagnosticsSignHint" })
