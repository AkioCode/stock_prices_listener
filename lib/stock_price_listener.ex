defmodule StockPriceListener do
  @moduledoc """
  Documentation for `StockPriceListener`.
  """
  use GenServer

  def start_link do
    initial_state = [
      fb: 10000,
      amz: 10000,
      aapl: 10000,
      nvda: 10000,
      goog: 10000
    ]
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @impl true
  def init(initial_arg) do
    {:ok, initial_arg}
  end
end
