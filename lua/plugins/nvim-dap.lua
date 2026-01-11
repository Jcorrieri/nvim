return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        'williamboman/mason.nvim', -- Ensure Mason is loaded first
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local mason_dap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")

        -- Dap Virtual Text
        dap_virtual_text.setup()

        -- Configurations
        mason_dap.setup({
            ensure_installed = { "codelldb", "python" },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        })

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}", -- This will debug the current file
                pythonPath = function()
                    -- Use the Python from your virtual environment if available
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return '/usr/bin/python3'
                    end
                end,
            },
            {
                type = 'python',
                request = 'launch',
                name = "Launch file with arguments",
                program = "${file}",
                args = function()
                    local args_string = vim.fn.input('Arguments: ')
                    return vim.split(args_string, " +")
                end,
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return '/usr/bin/python3'
                    end
                end,
            },
        }

        -- Dap UI

        ui.setup()

        vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
}
