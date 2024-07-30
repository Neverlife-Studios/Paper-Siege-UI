local UiController = require(script.Parent:WaitForChild("UiScripts"):WaitForChild("UiController"))

UiController:Init("UI", "LoadingScreen")

task.wait(5)

UiController:ShowPage("MainMenu")

task.wait(5)

UiController:ShowPage("Shop")

task.wait(5)

UiController:ShowPage("Settings")