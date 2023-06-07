return {
  colorscheme = "onedark",
  plugins = {
    {
      "navarasu/onedark.nvim",
      as = "onedark",
      config = function()
        require("onedark").setup({
          style = 'darker'
        })
      end,
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        signs = true,      -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ",                              -- icon used for the sign, and in search results
            color = "error",                            -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "NONE",         -- The gui style to use for the fg highlight group.
          bg = "BOLD",         -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true,                -- enable multine todo comments
          multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
          before = "",                     -- "fg" or "bg" or empty
          keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg",                    -- "fg" or "bg" or empty

          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true,            -- uses treesitter to match keywords in comments only
          max_line_len = 400,              -- ignore lines longer than this
          exclude = {},                    -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" }
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        }
      },
    },
    {
      "goolord/alpha-nvim",
      opts = function(_, opts)      -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          "                                                     ",
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
          "                                                     ",
          "    Hi, HongDaYu " .. os.date(),
        }
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-emoji", -- add cmp source as dependency of cmp
      },
      -- override the options table that is used in the `require("cmp").setup()` call
      opts = function(_, opts)
        local cmp = require "cmp"
        -- modify the sources part of the options table
        opts.sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
          { name = "emoji",    priority = 700 }, -- add new source
        }
        -- return the new table to be used
        return opts
      end,
    },
  },
  mappings = {
    n = {
      ["<leader>c"] = {
        function()
          local bufs = vim.fn.getbufinfo { buflisted = true }
          require("astronvim.utils.buffer").close(0)
          if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
        end,
        desc = "Close buffer",
      },
      ["<leader>gg"] = {
        function()
          require("astronvim.utils").toggle_term_cmd "gitui"
        end,
        desc =
        "ToggleTerm gitui" },
      ["<leader>tl"] = { function() require("astronvim.utils").toggle_term_cmd "gitui" end, desc = "ToggleTerm gitui" },
      ["<leader>tn"] = { function() require("astronvim.utils").toggle_term_cmd "joshuto" end, desc = "ToggleTerm joshuto" },
      ["<leader>tu"] = { function() require("astronvim.utils").toggle_term_cmd "btop" end, desc = "ToggleTerm btop" },
      ["<leader>t]"] = { function() require("todo-comments").jump_next() end, desc = "Todo Next" },
      ["<leader>t["] = { function() require("todo-comments").jump_prev() end, desc = "Todo Perv" },
    },
  },
  options = {
    opt = {
      cmdheight = 1,
    },
  },
  lsp = {
    formatting = {
      format_on_save = {
        enabled = true,
        all_filetypes = {
          "lua",
          "python",
          "c",
          "cpp",
        },
      },
    },
    config = {
      clangd = {
        single_file_support = true,
        cmd = {
          "clangd",
          "--background-index",
          "--pch-storage=memory",
          [[--query-driver=/usr/bin/clang++,
  /usr/bin/**/clang-*,/bin/clang,
  /bin/clang++,/usr/bin/gcc,
  /usr/bin/g++,
  /opt/sdk/aarch64/gcc-11/aarch64-buildroot-linux-gnu_sdk-buildroot/bin/aarch64-buildroot-linux-gnu-g++,
  /opt/sdk/aarch64/gcc-11/aarch64-buildroot-linux-gnu_sdk-buildroot/bin/aarch64-buildroot-linux-gnu-gcc,
  /opt/sdk/arm/arm-zynq-linux-gnueabihf_sdk-buildroot/bin/arm-zynq-linux-gnueabihf-g++,
  /opt/sdk/arm/arm-zynq-linux-gnueabihf_sdk-buildroot/bin/arm-zynq-linux-gnueabihf-gcc,
  /opt/petalinux/2019.2/sysroots/x86_64-petalinux-linux/usr/bin/arm-xilinx-linux-gnueabi/arm-xilinx-linux-gnueabi-g++,
  /opt/petalinux/2021.2/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-g++,
  /opt/petalinux/2019.2/sysroots/x86_64-petalinux-linux/usr/bin/arm-xilinx-linux-gnueabi/arm-xilinx-linux-gnueabi-gcc,
  /opt/petalinux/2022.2/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-gcc,
  /opt/petalinux/2022.2/sysroots/x86_64-petalinux-linux/usr/bin/aarch64-xilinx-linux/aarch64-xilinx-linux-g++]],
          "--clang-tidy",
          "--all-scopes-completion",
          "--cross-file-rename",
          "--completion-style=detailed",
          "--header-insertion-decorators",
          "--header-insertion=iwyu",
        },
      },
    },
  },
  highlights = {
    init = function()
      local get_hlgroup = require("astronvim.utils").get_hlgroup
      local normal = get_hlgroup "Normal"
      local fg, bg = normal.fg, normal.bg
      local bg_alt = get_hlgroup("Visual").bg
      local green = get_hlgroup("String").fg
      local red = get_hlgroup("Error").fg
      return {
        TelescopeBorder = { fg = bg_alt, bg = bg },
        TelescopeNormal = { bg = bg },
        TelescopePreviewBorder = { fg = bg, bg = bg },
        TelescopePreviewNormal = { bg = bg },
        TelescopePreviewTitle = { fg = bg, bg = green },
        TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
        TelescopePromptNormal = { fg = fg, bg = bg_alt },
        TelescopePromptPrefix = { fg = red, bg = bg_alt },
        TelescopePromptTitle = { fg = bg, bg = red },
        TelescopeResultsBorder = { fg = bg, bg = bg },
        TelescopeResultsNormal = { bg = bg },
        TelescopeResultsTitle = { fg = bg, bg = bg },
      }
    end,
  },
}
