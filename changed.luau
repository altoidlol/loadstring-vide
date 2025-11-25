local action = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/action.luau"))()()
local cleanup = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/cleanup.luau"))()

local function changed<T>(property: string, callback: (T) -> ())
    return action(function(instance)
        local con = instance:GetPropertyChangedSignal(property):Connect(function()
            callback((instance :: any)[property])
        end)

        cleanup(function()
            con:Disconnect()
        end)

        callback((instance :: any)[property])
    end)
end

return changed
