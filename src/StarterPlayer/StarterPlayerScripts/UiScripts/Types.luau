export type UiController = {
    CurrentPage: string,
    Effects: {table},
    Frames: {[string]: Frame},
    GuiInterface: ScreenGui,
    Pages: {[string]: table},

    Init: (Interface: string, StartingPage: string) -> (),
    InitPages: () -> (),
    LoadEffects: () -> (),
    LoadFrames: () -> (),
    LoadPages: () -> (),
    ShowPage: (Page: string) -> ()
}