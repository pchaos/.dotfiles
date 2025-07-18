local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

-- Function to get current timestamp
local get_timestamp = function()
  return os.date("%Y-%m-%d %H:%M:%S")
end

return {
  s("ctimestamp", { t("Created: "), f(get_timestamp, {}) }, { show_value = false, description = "create timestamp" }), -- show_value=false hides the function itself

  s("mtimestamp", { t("Modified: "), f(get_timestamp, {}) }, { show_value = false, description = "Modified timestamp" }),

  s("timestamp", { t("Last Modified: "), f(get_timestamp, {}) },
    { show_value = false, description = "timestamp on save file" }),
}
