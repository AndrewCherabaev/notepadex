defmodule Window do
  import :wxFrame
  alias :wx,            as: Wx
  alias :wxMenu,        as: WxMenu
  alias :wxMenuBar,     as: WxMenuBar
  alias :wxMenuItem,    as: WxMenuItem


  def main(_Args) do
    frame = Wx.new() |> new(-1, 'Hello world')
    frame |> center()
    frame |> show()
    frame |> initMenu() |> initCallbacks() |> loop()
    frame |> destroy()
  end

  def initCallbacks(frame) do
    frame |> connect(:close_window)
  end

  def initMenu(frame) do
    menu_bar = WxMenuBar.new()
    frame |> setMenuBar(menu_bar)

    menu = WxMenu.new()
    menu_bar |> WxMenuBar.append(menu, "&File")
    quit = WxMenuItem.new([{:id, 400}, {:text, "&Quit"}])
    menu |> WxMenu.append(quit)
    frame
  end

  def loop(frame) do
    receive do
      {_,_,_,_,{:wxClose, :close_window}} -> :ok
      _ -> loop(frame)
    end
  end
end