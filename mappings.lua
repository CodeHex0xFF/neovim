return {
  n = {
    ["<leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
    ["<leader>tn"] = {
      function() require("astronvim.utils").toggle_term_cmd "joshuto" end,
      desc = "ToggleTerm joshuto",
    },
    ["<leader>tu"] = { function() require("astronvim.utils").toggle_term_cmd "btop" end, desc = "ToggleTerm btop" },
    ["<leader>ts"] = { function() require("astronvim.utils").toggle_term_cmd "termscp" end, desc = "ToggleTerm btop" },
  },
}
