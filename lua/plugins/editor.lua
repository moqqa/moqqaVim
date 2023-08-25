return {{
    "nvim-treesitter/nvim-treesitter",
    dependencies = {"nvim-treesitter/nvim-treesitter-context", "RRethy/nvim-treesitter-endwise"},
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {"html", "javascript", "json", "luadoc", "luap", "markdown_inline", "tsx", "typescript",
                                "yaml", "lua", "markdown", "rust", "css"},
            highlight = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>"
                }
            },
            indent = {
                enable = true,
                disable = {"yaml"}
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner"
                    }
                }
            },
            endwise = {
                enable = true
            }
        })

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false
    end
}, {"utilyre/sentiment.nvim"}, {"Exafunction/codeium.vim"}, {
    "folke/flash.nvim",
    opts = {
        modes = {
            search = {
                enabled = false
            }
        }
    },
    keys = {{
        "s",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }, {
        "S",
        mode = {"n", "o", "x"},
        function()
            require("flash").treesitter()
        end,
        desc = "Flash treesitter"
    }, {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "Remote flash"
    }, {
        "R",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "Flash treesitter search"
    }, {
        "<C-s>",
        mode = {"c"},
        function()
            require("flash").toggle()
        end,
        desc = "Toggle flash search"
    }}
}, {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
                ["config.lsp.signature.enabled"] = false,
                ["config.lsp.signature.enabled"] = false
            }
        },
        routes = {{
            filter = {
                event = "msg_show",
                any = {{
                    find = "%d+L, %d+B"
                }, {
                    find = "; after #%d+"
                }, {
                    find = "; before #%d+"
                }}
            },
            view = "mini"
        }},
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true
        }
    },
    keys = {{
        "<S-Enter>",
        function()
            require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline"
    }, {
        "<leader>snl",
        function()
            require("noice").cmd("last")
        end,
        desc = "Noice Last Message"
    }, {
        "<leader>snh",
        function()
            require("noice").cmd("history")
        end,
        desc = "Noice History"
    }, {
        "<leader>sna",
        function()
            require("noice").cmd("all")
        end,
        desc = "Noice All"
    }, {
        "<leader>snd",
        function()
            require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All"
    }, {
        "<c-f>",
        function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = {"i", "n", "s"}
    }, {
        "<c-b>",
        function()
            if not require("noice.lsp").scroll(-4) then
                return "<c-b>"
            end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = {"i", "n", "s"}
    }}
}}
