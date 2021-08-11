defmodule AccountTest do
  use ExUnit.Case

  test "initial balance is zero" do
    {:ok, pid} = Account.start_link()

    assert 0 == Account.get_balance(pid)
  end
end
