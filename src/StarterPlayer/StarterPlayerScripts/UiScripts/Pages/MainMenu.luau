-- Used as a template

local function TableLength(arr)
    local len = 0
    for _,v in ipairs(arr) do
        len += 1
    end
    return len
end

local Name = script.Name
local Connections = {
    ButtonClickEffect = {}
}
local Page = {
    UiController = nil,
    Frame = {}
}

function Page:LoadConnections()
    print(Name.." Page => Add connections and stuff")
    for _, Element in self.Frame:GetDescendants() do
        if Element:IsA("TextButton") or Element:IsA("ImageButton") then
            if not Element.Active then continue end
            Connections.ButtonClickEffect[TableLength(Connections.ButtonClickEffect)] = Element.MouseButton1Click:Connect(self.UiController.Effects.Button["Click"])
        end
    end
end

function Page:Init(UiController, Frame)
    print(Name.." Page => Init")
    if not UiController then
        error(Name.." Page => UiController is invalid")
        return
    end
    if not Frame then
        error(Name.." Page => Frame is invalid")
        return
    end
    self.UiController = UiController
    self.Frame = Frame
    self:LoadConnections()
end

return Page