defmodule Board do
  defstruct \
    left:   %Pole{plates: Enum.map(1..5, fn x -> %Plate{width: x} end)},
    center: %Pole{},
    right:  %Pole{}

  defimpl String.Chars, for: Board do
    def to_string(board) do
      Enum.reduce([board.right, board.center, board.left], "", fn plate, acc -> "#{plate}" <> "\n" <> acc end)
    end
  end
end