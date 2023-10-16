-- Disable search highlighting when pressing escape
vim.keymap.set("n", "<ESC>", "<CMD>noh<CR><ESC>", { noremap = true, silent = true })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })

-- No Neck Pain
local no_neck_pain = require("no-neck-pain")
vim.keymap.set("n", "<leader>nnp", no_neck_pain.toggle, { desc = "[N]o [N]eck [P]ain" })
