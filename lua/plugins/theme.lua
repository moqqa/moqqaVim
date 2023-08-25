return {{
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {{
        "linrongbin16/lsp-progress.nvim",
        opts = {}
    }, "KadoBOT/nvim-spotify"},
    opts = {
        options = {
            icons_enabled = false,
            theme = "auto",
            component_separators = {
                left = " ",
                right = " "
            },
            section_separators = {
                left = "",
                right = ""
            },
            globalstatus = true
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"filename"},
            lualine_c = {"require('lsp-progress').progress()"},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {"require('nvim-spotify').status.listen()"}
        }
    }
}, {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {}
}, {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
• ▌ ▄ ·.       .▄▄▄  .▄▄▄   ▄▄▄· 
·██ ▐███▪▪     ▐▀•▀█ ▐▀•▀█ ▐█ ▀█ 
▐█ ▌▐▌▐█· ▄█▀▄ █▌·.█▌█▌·.█▌▄█▀▀█ 
██ ██▌▐█▌▐█▌.▐▌▐█▪▄█·▐█▪▄█·▐█ ▪▐▌
▀▀  █▪▀▀▀ ▀█▄▀▪·▀▀█. ·▀▀█.  ▀  ▀ 
        git@github:moqqa/        
          ]]

        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                                         dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                                         dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                                         dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                                         dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                                         dashboard.button("s", " " .. " Restore Session",
            [[:lua require("persistence").load() <cr>]]), dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
                                         dashboard.button("q", " " .. " Quit", ":qa<CR>")}
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.opts.layout[1].val = 8
        return dashboard
    end,
    config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end
            })
        end

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end
        })
    end
}, {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
        integrations = {
            alpha = true,
            cmp = true,
            flash = true,
            gitsigns = true,
            illuminate = true,
            indent_blankline = {
                enabled = true
            },
            lsp_trouble = true,
            mason = true,
            mini = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = {"undercurl"},
                    hints = {"undercurl"},
                    warnings = {"undercurl"},
                    information = {"undercurl"}
                }
            },
            navic = {
                enabled = true,
                custom_bg = "lualine"
            },
            neotest = true,
            noice = true,
            notify = true,
            neotree = true,
            semantic_tokens = true,
            telescope = true,
            treesitter = true,
            which_key = true
        },
        color_overrides = {
            mocha = {
                base = "#000000",
                mantle = "#010101",
                crust = "#020202"
            }
        }
    }
}, {
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "catppuccin"
    }
}}
