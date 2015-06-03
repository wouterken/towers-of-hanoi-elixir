defmodule Solver do

  def solve(board) do
    board |> move_tower(5, :left, :center)
  end

  def move_tower(board, disk, from, to) do
    move_tower(board, disk, from, to, hd([:left, :right, :center] -- [from, to]))
  end

  def move_tower(board, disk, from, to, spare) do
    if disk == 1 do
      IO.puts "Moving #{disk} from #{from} to #{to}"
      shift(board, from, to)
    else
      board = move_tower(board, disk - 1, from, spare)
      IO.puts "Moving #{disk} from #{from} to #{to}"
      board |>
      shift(from, to) |>
      move_tower(disk - 1, spare, to)
    end
  end

  def shift(board, from, to) when from == to, do: board
  def shift(board, from, to) do

    [from_pole, to_pole]  = [get_pole(board, from), get_pole(board, to)]
    [head|tail] = [%{width: head_width}|tail] = from_pole.plates

    case to_pole.plates do
      [%{width: width}, _] when width < head_width ->
        print_board(board)
        raise "Not allowed to put plate with width: #{head_width} ontop of: #{width}"
      [%{width: width}] when width < head_width ->
        print_board(board)
        raise "Not allowed to put plate with width: #{head_width} ontop of: #{width}"
      _ ->
     end

    board
    |>
    Map.put(:"#{to}", %{to_pole   | plates: [head] ++ to_pole.plates})
    |>
    Map.put(:"#{from}", %{from_pole | plates: tail})
    |>
    print_board
  end

  def print_board(board),        do: IO.puts(board) && board
  def get_pole(board, :left  ),  do: board.left
  def get_pole(board, :center),  do: board.center
  def get_pole(board, :right ),  do: board.right
end