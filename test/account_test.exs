defmodule AccountTest do
  use ExUnit.Case

  test "initial balance is zero" do
    {:ok, pid} = Account.start_link()

    assert 0 == Account.get_balance(pid)
  end

  test "depositing money changes the balance" do
    {:ok, pid} = Account.start_link()

    Account.deposit(pid, 10.0)

    assert 10.0 == Account.get_balance(pid)
  end

  test "withdraw money reduces the balance" do
    {:ok, pid} = Account.start_link()

    Account.withdraw(pid, 52.34)

    assert -52.34 == Account.get_balance(pid)
  end
end
