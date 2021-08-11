defmodule Account do
  use GenServer

  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def get_balance(pid) do
    GenServer.call(pid, :get_balance)
  end

  def deposit(pid, amount) do
    GenServer.cast(pid, {:deposit, amount})
  end

  def withdraw(pid, amount) do
    GenServer.cast(pid, {:withdraw, amount})
  end

  def handle_call(:get_balance, _from, state) do
    {:reply, Map.get(state, :balance), state}
  end

  def handle_cast({:deposit, amount}, state) do
    # balance = Map.get(state, :balance)
    # {:noreply, Map.put(state, :balance, balance + amount)}

    {_value, balance_with_deposit} =
      Map.get_and_update(state, :balance, fn balance -> {balance, balance + amount} end)

    {:noreply, balance_with_deposit}
  end

  def handle_cast({:withdraw, amount}, state) do
    # Extracted anonymous function
    update_balance = fn balance, amount -> balance - amount end

    {_value, updated_balance} =
      Map.get_and_update(state, :balance, fn balance ->
        # calling the function instead of doing a calculation
        {balance, update_balance.(balance, amount)}
      end)

    {:noreply, updated_balance}
  end
end
