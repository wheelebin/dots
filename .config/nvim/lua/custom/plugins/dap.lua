return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'mxsdev/nvim-dap-vscode-js',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local dap_utils = require 'dap.utils'

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()

      require('dap-vscode-js').setup {
        debugger_path = os.getenv 'HOME' .. '/.config/nvim/code-debuggers/js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }
      local exts = {
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
      }

      for i, ext in ipairs(exts) do
        dap.configurations[ext] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node)',
            cwd = vim.fn.getcwd(),
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node with ts-node)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '--loader', 'ts-node/esm' },
            runtimeExecutable = 'node',
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            resolveSourceMapLocations = {
              '${workspaceFolder}/**',
              '!**/node_modules/**',
            },
          },
          {
            type = 'pwa-chrome',
            request = 'attach',
            name = 'Attach Program (pwa-chrome, select port)',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = function()
              return vim.fn.input('Select port: ', 9222)
            end,
            webRoot = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach Program (pwa-node, select pid)',
            cwd = vim.fn.getcwd(),
            processId = dap_utils.pick_process,
            skipFiles = { '<node_internals>/**' },
          },
        }
      end

      -- TODO: For some reason I have to run dapDebug manually before starting a session, make it automatic
      -- TODO: Add better keymaps for debugging
      -- TODO: Add support for php as well (https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#php)

      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { os.getenv 'HOME' .. '/.config/nvim/code-debuggers/php-debug/out/phpDebug.js' },
      }
      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug (FROM NVIM CONFIG)',
          port = 9003,
        },
      }

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '8123',
        executable = {
          command = 'node',
          args = { os.getenv 'HOME' .. '/.config/nvim/code-debuggers/js-debug/src/dapDebugServer.js', '8123' },
        },
      }
      vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>dc', dap.continue)
      vim.keymap.set('n', '<leader>dx', dap.disconnect)
      vim.keymap.set('n', '<leader>du', ui.toggle)
      -- Eval var under cursor
      vim.keymap.set('n', '<leader>d?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      dap.set_log_level 'TRACE'

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
  },
}
