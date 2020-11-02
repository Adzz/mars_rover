defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  describe "rove/3" do
    test "We can move about a bit" do
      assert MarsRover.rove({2, 3, "N"}, {4, 8}, "FLLFR") == {2, 3, "W"}
    end

    test "because Mars is flat we can fall off the planet" do
      assert MarsRover.rove({1, 0, "S"}, {4, 8}, "FFRLF") == {{1, 0, "S"}, "LOST"}
    end

    test "We can circumvent the area" do
      assert MarsRover.rove({0, 0, "E"}, {4, 4}, "FFFLFFFLFFFLFFFL") == {0, 0, "E"}
    end

    test "We can compose operations together" do
      result =
        MarsRover.rove({0, 0, "E"}, {4, 4}, "FFFL")
        |> MarsRover.rove({4, 4}, "FFFL")
        |> MarsRover.rove({4, 4}, "FFFL")
        |> MarsRover.rove({4, 4}, "FFFL")

      assert result == {0, 0, "E"}
    end
  end
end
