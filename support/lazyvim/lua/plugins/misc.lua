return {
  -- ChatGPT.nvim -- Neovim plugin for interacting with OpenAI GPT-3 chatbot, providing an easy interface for exploring GPT-3 and NLP.
  "jackMort/ChatGPT.nvim",
  cmd = { "ChatGPT", "ChatGPTActAs" },
  config = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
