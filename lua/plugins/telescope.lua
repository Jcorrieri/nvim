return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',  -- Compatible with 0.9.5
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fc', function() 
      require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
    end, desc = 'Find config files' },
  },
}
