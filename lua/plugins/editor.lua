return {{"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufReadPost", "BufNewFile"},
    cmd = {"TSInstall", "TSUpdate"},
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"c", "css", "html", "json", "javascript", "luadoc", "luap", "markdown_inline", "tsx",
                                "typescript", "lua", "markdown", "python", "rust"},
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
                disable = {"python"}
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

        require("treesitter-context").setup({
            max_lines = 3,
            min_window_height = 20,
            mode = "topline"
        })
    end
}, {
    "folke/flash.nvim",
    event = "VeryLazy",
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
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
        suggestion = {
            auto_trigger = true
        }
    }
}, {
    "bennypowers/splitjoin.nvim",
    keys = {{
        "gj",
        function()
            require("splitjoin").join()
        end,
        desc = "Join the object under cursor"
    }, {
        "g,",
        function()
            require("splitjoin").split()
        end,
        desc = "Split the object under cursor"
    }}
},
 
}
