defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  describe "rove/3" do
    test "We can move about a bit" do
      assert MarsRover.rove({4, 8}, {2, 3, "N"}, "FLLFR") == {2, 3, "W"}
    end

    test "because Mars is flat we can fall off the planet" do
      assert MarsRover.rove({4, 8}, {1, 0, "S"}, "FFRLF") == {{1, 0, "S"}, "LOST"}
    end
  end
end
