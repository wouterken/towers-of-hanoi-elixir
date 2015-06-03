defmodule Plate do
  defstruct width: 1

  defimpl String.Chars, for: Plate do
    def to_string(plate) do
      "[#{String.duplicate("-", plate.width)}]"
    end
  end

end
