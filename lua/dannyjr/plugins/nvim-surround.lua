-- ~/.config/nvim/lua/dannyjr/plugins/surround.lua

require("nvim-surround").setup({
  surrounds = {
    ["$"] = {
      add = { "$", "$" },
      find = "%$[^$]*%$",
      delete = "^(%$)().-(%$)()$",
      change = {
        target = "^%$(.-)%$$",
        replacement = function()
          return { "\\begin{equation}\n", "\n\\end{equation}" }
        end,
      },
    },
    ["e"] = {
      add = { "\\begin{equation}\n", "\n\\end{equation}" },
      find = "\\begin{equation}.-\\end{equation}",
      delete = "^(\\begin{equation})().-(\\end{equation})()$",
      change = {
        target = "^\\begin{equation}(.-)\\end{equation}$",
        replacement = function()
          return { "$", "$" }
        end,
      },
    },
  },
})



