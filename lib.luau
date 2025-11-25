local version = { major = 0, minor = 3, patch = 1 }

local root = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/root.luau"))
local branch = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/branch.luau"))
local mount = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/mount.luau"))
local create = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/create.luau"))
local apply = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/apply.luau"))
local source = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/source.luau"))
local effect = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/effect.luau"))
local derive = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/derive.luau"))
local cleanup = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/cleanup.luau"))
local untrack = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/untrack.luau"))
local read = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/read.luau"))
local batch = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/batch.luau"))
local context = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/context.luau"))
local switch = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/switch.luau"))
local show = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/show.luau"))
local indexes = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/indexes.luau"))
local values = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/values.luau"))
local spring, update_springs = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/spring.luau"))()
local action = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/action.luau"))()
local changed = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/changed.luau"))
local timeout, update_timeouts = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/timeout.luau"))()
local flags = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/flags.luau"))

export type Source<T> = source.Source<T>
export type source<T> = Source<T>
export type Context<T> = context.Context<T>
export type context<T> = Context<T>

local function step(dt: number)
    if game then debug.profilebegin("VIDE STEP") end

    if game then debug.profilebegin("VIDE SPRING") end
    update_springs(dt)
    if game then debug.profileend() end

    if game then debug.profilebegin("VIDE SCHEDULER") end
    update_timeouts(dt)
    if game then debug.profileend() end

    if game then debug.profileend() end
end

local stepped = game and game:GetService("RunService").Heartbeat:Connect(function(dt: number)
    task.defer(step, dt)
end)

local vide = {
    version = version,

    -- core
    root = root,
    --branch = branch,
    mount = mount,
    create = create,
    source = source,
    effect = effect,
    derive = derive,
    switch = switch,
    show = show,
    indexes = indexes,
    values = values,

    -- util
    cleanup = cleanup,
    untrack = untrack,
    read = read,
    batch = batch,
    context = context,

    -- animations
    spring = spring,

    -- actions
    action = action,
    changed = changed,

    -- flags
    strict = (nil :: any) :: boolean,
    defaults = (nil :: any) :: boolean,
    defer_nested_properties = (nil :: any) :: boolean,

    -- temporary
    apply = function(instance: Instance)
        return function(props: { [any]: any })
            apply(instance, props)
            return instance
        end
    end,

    -- runtime
    step = function(dt: number)
        if stepped then
            stepped:Disconnect()
            stepped = nil
        end
        step(dt)
    end
}

setmetatable(vide :: any, {
    __index = function(_, index: unknown): ()
        if flags[index] == nil then
            error(`{tostring(index)} is not a valid member of vide`, 0)
        else
            return flags[index]
        end
    end,

    __newindex = function(_, index: unknown, value: unknown)
        if flags[index] == nil then
            error(`{tostring(index)} is not a valid member of vide, 0`)
        else
            flags[index] = value
        end
    end
})

return vide
