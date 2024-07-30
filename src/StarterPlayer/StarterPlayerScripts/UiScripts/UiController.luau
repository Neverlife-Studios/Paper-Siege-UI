local Types = require(script.Parent:WaitForChild("Types"))
local PagesFolder = script.Parent:WaitForChild("Pages")
local EffectsFolder = script.Parent:WaitForChild("Effects")

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
    @prop Effects {table}
    @client
    @within UiController
    Contains the various UI Effects which can be utilised by various UI elements
]=]
UiController.Effects = {}

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
    print("UiController => Init")
    self.GuiInterface = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(Interface)

    if not self.GuiInterface then
        error("UI Controller => I lack the power to create the inital spark")
    end

    self:LoadFrames()

    self:LoadEffects()

    self:LoadPages()

    self:InitPages()

    if self.Frames[StartingPage] then
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
    print("UiController => Init pages")
    for Name, Page in self.Pages do
        Page:Init(self, self.Frames[Name])
    end
end

--[=[
    @client
    Loads all the UI Effects from Effects folder
]=]
function UiController:LoadEffects()
    print("UiController => Load effects")
    for _, Effect in EffectsFolder:GetChildren() do
        self.Effects[Effect.Name] = require(Effect)
    end
end

--[=[
    @client
    Loads the frames from GuiInterface
]=]
function UiController:LoadFrames()
    print("UiController => Load frames")
    for _, Frame in self.GuiInterface:GetChildren() do
        if not Frame:IsA("Frame") then continue end
        self.Frames[Frame.Name] = Frame
    end
end

--[=[
    @client
    Loads the pages from Pages folder
]=]
function UiController:LoadPages()
    print("UiController => Load pages")
    for _, Page in PagesFolder:GetChildren() do
        self.Pages[Page.Name] = require(Page)
    end
end

--[=[
    @client
    Makes a page visible

    @param Page string -- The name of the page to be made visible
]=]
function UiController:ShowPage(Page: string)
    print("UiController => Show page: "..Page)
    if self.CurrentPage == Page then return end
    if not self.Frames[Page] then
        error("UI Controller => Invalid page to display: "..Page)
        return
    end

    for _, Frame in self.Frames do
        if Frame.Name == Page then
            Frame.Visible = true
        else
            Frame.Visible = false
        end
    end
    self.CurrentPage = Page
end

return UiController