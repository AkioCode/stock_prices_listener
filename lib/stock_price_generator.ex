defmodule StockPriceGenerator do
  @moduledoc """
  A GenServer that simulates stock price generation and broadcasts updates
  to subscribers using Phoenix PubSub.
  """
  use GenServer

  @impl true
  def init(period) do
    Process.send_after(self(), {:loop, period}, period)
    {:ok, []}
  end

  @impl true
  def handle_info({:loop, period}, state) do
    loop(period)
    {:noreply, state}
  end

  defp loop(period) do
    Enum.each(~w(FB AMZ AAPL NVDA GOOG), fn ticker ->
      price = Enum.random(1_000..20_000)
      Phoenix.PubSub.broadcast(StockPriceListener.PubSub, ticker, {ticker, price})
    end)

    Process.send_after(self(), {:loop, period}, period)
  end
end
