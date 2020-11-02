defmodule MarsRover do
  @moduledoc """
  It's a God-awful small affair... To the girl with the mousy hair...
  """

  @doc """
  Roving works by treating the movements as a sequence of steps to reduce over, each step altering
  the position of the rover. That way we don't need the concept of a board at all except to set the
  boundaries for the X and Y position.
  """
  def rove({x, y}, starting_position, movements) do
    parse_movements(movements)
    |> Enum.reduce_while(starting_position, fn movement, rover_position ->
      new_position = {new_x, new_y, _} = update_position(rover_position, movement)

      if out_of_bounds?({new_x, new_y}, {x, y}) do
        # This returns the last known position before it fell off the world.
        {:halt, {rover_position, "LOST"}}
      else
        {:cont, new_position}
      end
    end)
  end

  defp out_of_bounds?({new_x, new_y}, {x, y}) do
    max_x = x + 1
    min_x = 0
    max_y = y + 1
    min_y = 0

    new_x > max_x or new_x < min_x or new_y > max_y or new_y < min_y
  end

  defp update_position({x_position, y_position, "N"}, "F"), do: {x_position, y_position + 1, "N"}
  defp update_position({x_position, y_position, "E"}, "F"), do: {x_position + 1, y_position, "E"}
  defp update_position({x_position, y_position, "S"}, "F"), do: {x_position, y_position - 1, "S"}
  defp update_position({x_position, y_position, "W"}, "F"), do: {x_position - 1, y_position, "W"}

  defp update_position({x_position, y_position, "N"}, "L"), do: {x_position, y_position, "W"}
  defp update_position({x_position, y_position, "N"}, "R"), do: {x_position, y_position, "E"}

  defp update_position({x_position, y_position, "S"}, "L"), do: {x_position, y_position, "E"}
  defp update_position({x_position, y_position, "S"}, "R"), do: {x_position, y_position, "W"}

  defp update_position({x_position, y_position, "E"}, "L"), do: {x_position, y_position, "N"}
  defp update_position({x_position, y_position, "E"}, "R"), do: {x_position, y_position, "S"}

  defp update_position({x_position, y_position, "W"}, "L"), do: {x_position, y_position, "S"}
  defp update_position({x_position, y_position, "W"}, "R"), do: {x_position, y_position, "N"}

  # There are a few ways we can go with invalid input, it all depends. We could :error, raise an
  # exception filter out and ignore any invalid commands..... Right now we don't do anything.
  # but if I were going to it I would do it here.
  defp parse_movements(movements), do: String.codepoints(movements)
end
