local Types = require(script.Parent:WaitForChild("Types"))
local Pages = script.Parent:WaitForChild("Pages")

--[=[
    @class UiController
    @client
    Handles everything related to GUI
]=]
local UiController: Types.UiController = {}

--[=[
    @prop CurrentPage string
    @client
    @within UiController
    Tells which page is currently being displayed
]=]
UiController.CurrentPage = ""

--[=[
    @prop Frames {Frame}
    @client
    @within UiController
    Contains the frame for each page
]=]
UiController.Frames = {}

--[=[
    @prop GuiInterface ScreenGui
    @client
    @within UiController
    The ScreenGui used by the UiController
]=]
UiController.GuiInterface = {}

--[=[
    @prop Pages {table}
    @client
    @within UiController
    Contains the controllers for each page
]=]
UiController.Pages = {}

--[=[
    @client
    Starts the controller, literally

    @param Interface string -- The name of the interface to look for in PlayerGui
    @param StartingPage string -- The name of a page to be made visible as default
]=]
function UiController:Init(Interface: string, StartingPage: string)
    self.GuiInterface = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(Interface)

    if not self.GuiInterface then
        error("UI Controller => I lack the power to create the inital spark")
    end

    Pages = script.Parent:WaitForChild("Pages")

    self:LoadFrames()

    for Page in Pages:GetChildren() do
        self.Pages[Page.Name] = require(Page)
    end

    self:InitPages()

    if self.Pages[StartingPage] and self.Frames[StartingPage] then
        self:ShowPage(StartingPage)
    else
        error("UI Controller => Invalid starting page: "..StartingPage)
    end
end

--[=[
    @client
    Starts all the pages one-by-one, literally
]=]
function UiController:InitPages()
    for Page in self.Pages do
        Page:Init(self)
    end
end

--[=[
    @client
    Loads the frames from GuiInterface
]=]
function UiController:LoadFrames()
    for Frame in self.GuiInterface:GetChildren() do
        if not Frame:IsA("Frame") then continue end
        self.Frames[Frame.Name] = Frame
    end
end

--[=[
    @client
    Makes a page visible

    @param Page string -- The name of the page to be made visible
]=]
function UiController:ShowPage(Page: string)
    if self.CurrentPage == Page then return end
    if not self.Frames[Page] then
        error("UI Controller => Invalid page to show: "..Page)
        return
    end

    self.Frames[self.CurrentPage].Visible = true
    self.CurrentPage = Page
    self.Frames[Page].Visible = false
end

return UiController