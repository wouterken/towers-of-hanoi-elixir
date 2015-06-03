defmodule Pole do
  defstruct plates: []

  defimpl String.Chars, for: Pole do
    def to_string(pole) do
      Enum.reduce(pole.plates, "", fn plate, acc -> "#{plate}" <> "," <> acc end)
    end
  end

end
