export type UiController = {
    CurrentPage: string,
    Frames: {[string]: Frame},
    GuiInterface: ScreenGui,
    Pages: {[string]: table},

    Init: (Interface: string, StartingPage: string) -> (),
    InitPages: () -> (),
    LoadFrames: () -> (),
    ShowPage: (Page: string) -> ()
}