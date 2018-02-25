defmodule Window do
  alias :wx,            as: Wx
  alias :wxFrame,       as: WxFrame
  alias :wxClose,       as: WxClose
  alias :close_window,  as: CloseWindow


  def main(_Args) do
    frame = Wx.new() |> WxFrame.new(-1, 'Hello world')

    frame |> WxFrame.show()
    frame |> initCallbacks() |> loop()
    frame |> WxFrame.destroy()
  end

  def initCallbacks(frame) do
    frame |> WxFrame.connect(CloseWindow)
  end

  def loop(frame) do
    receive do
      {_,_,_,_,{WxClose, CloseWindow}} -> :ok
      _ -> loop(frame)
    end
  end
end