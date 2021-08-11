defmodule Account do
  use GenServer

  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  # API
  def get_balance(pid) do
    GenServer.call(pid, :get_balance)
  end

  def deposit(pid, amount) do
    GenServer.cast(pid, {:deposit, amount})
  end

  def withdraw(pid, amount) do
    GenServer.cast(pid, {:withdraw, amount})
  end

  # Callbacks
  def handle_call(:get_balance, _from, state) do
    {:reply, Map.get(state, :balance), state}
  end

  # def handle_cast({:deposit, amount}, state) do
  #   # balance = Map.get(state, :balance)
  #   # {:noreply, Map.put(state, :balance, balance + amount)}

  #   {_value, balance_with_deposit} =
  #     Map.get_and_update(state, :balance, fn balance -> {balance, balance + amount} end)

  #   {:noreply, balance_with_deposit}
  # end

  def handle_cast({:deposit, amount}, state) do
    {:noreply, get_updated_balance(state, amount, &(&1 + &2))}
  end

  # def handle_cast({:withdraw, amount}, state) do
  #   # We can use the & syntax, which allows us to create a smaller anonymous function,
  #   # and reference each argument by its index &N—where N is some index.
  #   {:noreply, change_balance(state, amount, &(&1 - &2))}
  # end

  def handle_cast({:withdraw, amount}, state) do
    {:noreply, get_updated_balance(state, amount, &(&1 - &2))}
  end

  # extracted function
  # defp change_balance(state, amount, calculate_balance) do
  #   {_value, updated_balance} =
  #     Map.get_and_update(state, :balance, fn balance ->
  #       {balance, calculate_balance.(balance, amount)}
  #     end)

  #   updated_balance
  # end

  # private
  defp get_updated_balance(state, amount, calculate_balance) do
    {_value, updated_balance} =
      Map.get_and_update(state, :balance, fn balance ->
        {balance, calculate_balance.(balance, amount)}
      end)

    updated_balance
  end
end
