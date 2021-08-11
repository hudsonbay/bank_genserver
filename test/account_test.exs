defmodule AccountTest do
  use ExUnit.Case

  test "initial balance is zero" do
    {:ok, pid} = Account.start_link()
  end
end
