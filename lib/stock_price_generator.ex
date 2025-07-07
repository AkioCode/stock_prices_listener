defmodule StockPriceGenerator do
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
    Enum.each(~w(fb amz aapl nvda goog), fn ticker ->
      price = Enum.random(1000..20000)
      Phoenix.PubSub.broadcast(StockPriceListener.PubSub, ticker, {ticker, price})
    end)

    Process.send_after(self(), {:loop, period}, period)
  end
end
