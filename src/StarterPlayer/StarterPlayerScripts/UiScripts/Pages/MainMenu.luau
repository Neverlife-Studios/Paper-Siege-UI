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
                self.UiController:ShowPage(Element.Name)
                if Element == ReturnButton then
                    if self.PreviousPage == "" then return end
                    self.UiController:ShowPage(self.PreviousPage)
                end
            end)
            Element.MouseEnter:Connect(function()
                self.UiController.Effects.Button["Hover"]()
                print(Name.." Page => "..Element.Name.." mouse enter")
                Element.TextSize = 20
                Element.Description.Visible = true
            end)
            Element.MouseLeave:Connect(function()
                self.UiController.Effects.Button["Hover"]()
                print(Name.." Page => "..Element.Name.." mouse leave")
                Element.TextSize = 14
                Element.Description.Visible = false
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
    self:LoadConnections()
end

return Page