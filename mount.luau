local root = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/root.luau"))()
local apply = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/apply.luau"))()

local function mount<T>(component: () -> T, target: Instance?): () -> ()
    return root(function()
        local result = component()
        if target then apply(target, { result }) end
    end)
end

return mount :: (<T>(component: () -> T, target: Instance) -> () -> ()) & ((component: () -> ()) -> () -> ())
