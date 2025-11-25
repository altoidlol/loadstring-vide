local flags = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/flags.luau"))()
local graph = loadstring(game:HttpGet("https://raw.githubusercontent.com/altoidlol/loadstring-vide/refs/heads/main/graph.luau"))()

local function batch(setter: () -> ())
    local already_batching = flags.batch
    local from

    if not already_batching then
        flags.batch = true
        from = graph.get_update_queue_length()
    end

    local ok, err: string? = xpcall(setter, debug.traceback)

    if not already_batching then
        flags.batch = false
        graph.flush_update_queue(from)
    end

    if not ok then error(`error occured while batching updates: {err}`, 0) end
end

return batch
