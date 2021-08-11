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

  def handle_call(:get_balance, _from, state) do
    {:reply, Map.get(state, :balance), state}
  end
end
