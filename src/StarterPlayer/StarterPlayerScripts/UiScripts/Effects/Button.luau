local Effect = {
    UiController = nil
}

Effect["Click"] = function ()
    Effect.UiController.Sounds.ButtonClick:Play()
    print("Button click")
end

Effect["Hover"] = function ()
    Effect.UiController.Sounds.ButtonHover:Play()
    print("Button hover")
end

return Effect