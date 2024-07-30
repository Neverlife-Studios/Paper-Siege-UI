-- Used as a template

local Connections = {}
local Page = {
    UiController = nil,
}

local function LoadConnections()
    print("Add connections and stuff")
end

function Page:Init(UiController)
    self.UiController = UiController
    LoadConnections()
end

return Page