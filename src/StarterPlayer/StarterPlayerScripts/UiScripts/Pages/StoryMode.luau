-- Used as a template

local Name = script.Name
local Page = {
    UiController = nil,
    Frame = {},
    PreviousPage = ""
}

local ReturnButton = nil

function Page:LoadConnections()
    print(Name.." Page => Add connections and stuff")
    for _, Element in self.Frame:GetDescendants() do
        if Element:IsA("TextButton") or Element:IsA("ImageButton") then
            if not Element.Active then continue end
            Element.MouseButton1Click:Connect(function()
                self.UiController.Effects.Button["Click"]()
                if Element == ReturnButton then
                    if self.PreviousPage == "" then return end
                    self.UiController:ShowPage(self.PreviousPage)
                end
            end)
            Element.MouseEnter:Connect(function()
                self.UiController.Effects.Button["Hover"]()
            end)
            Element.MouseLeave:Connect(function()
                self.UiController.Effects.Button["Hover"]()
            end)
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
    ReturnButton = self.Frame.Main.Return
    self:LoadConnections()
end

return Page