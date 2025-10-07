local M = {}
function M.setup()
    require("codecompanion").setup({
        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = os.getenv("ANTHROPIC_API_KEY"),
                    },
                })
            end
        },
        strategies = {
            chat = {
                adapter = "anthropic",
            },
            inline = {
                adapter = "anthropic",
            },
            cmd = {
                adapter = "anthropic",
            }
        }
    })
end

return M
