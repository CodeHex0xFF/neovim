local M ={}
M.setup = function ()
  if vim.g.neovide then
    local alpha = function()
      return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
    end

    vim.o.guifont = "JetBrainsMono Nerd Font:h14" -- text below applies for VimScript
    vim.g.neovide_transparency = 0.65
    vim.g.transparency = 0.65
    vim.g.neovide_background_color = "#0f1117" .. alpha()
    vim.g.neovide_window_blurred = true
  end
end
return M
