defmodule BankGenserverTest do
  use ExUnit.Case
  doctest BankGenserver

  test "greets the world" do
    assert BankGenserver.hello() == :world
  end
end
