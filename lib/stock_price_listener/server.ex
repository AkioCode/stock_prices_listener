defmodule StockPriceListener.Server do
  @moduledoc """
  StockPriceListener.Server is a GenServer that listens for stock price updates and allows clients to subscribe or unsubscribe to stock tickers.
  """
  use GenServer

  @tickers ~w(fb amz aapl nvda goog)

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(subscribed) do
    Enum.each(subscribed, fn ticker ->
      Phoenix.PubSub.subscribe(StockPriceListener.PubSub, ticker, link: true)
    end)
    {:ok, subscribed}
  end

  @impl true
  def handle_call(:subscribe_all, _from, _state) do
    Enum.each(@tickers, fn ticker ->
      Phoenix.PubSub.subscribe(StockPriceListener.PubSub, ticker, link: true)
    end)
    {:reply, "Subscribed to all", @tickers}
  end

  def handle_call(:unsubscribe_all, _from, _state) do
    Enum.each(@tickers, fn ticker ->
      Phoenix.PubSub.unsubscribe(StockPriceListener.PubSub, ticker)
    end)
    {:reply, "Unsubscribed from all", []}
  end

  def handle_call({:subscribe, ticker}, _from, state) when ticker in @tickers do
    Phoenix.PubSub.subscribe(StockPriceListener.PubSub, ticker, link: true)
    {:reply, "Subscribed to #{String.upcase(ticker)} updates", state ++ [ticker]}
  end

  def handle_call({:unsubscribe, ticker}, _from, state)  when ticker in @tickers do
    Phoenix.PubSub.unsubscribe(StockPriceListener.PubSub, ticker)
    {:reply, "Unsubscribed from #{String.upcase(ticker)} updates", state -- [ticker]}
  end

  def handle_call({action, ticker}, _from, state) when action in [:subscribe, :unsubscribe] do
    {:reply, "#{String.upcase(ticker)} not found!", state}
  end

  @impl true
  def handle_info("crash", state) do
    0/0
    {:noreply, state}
  end

  def handle_info({:DOWN, _ref, :process, _pid, _reason}, state) do
    IO.inspect(state)
    {:noreply, state}
  end

  def handle_info({ticker, price}, state) do
    IO.puts("#{String.upcase(ticker)}: #{view_price(price)}")
    {:noreply, state}
  end

  defp view_price(price) do
    price
    |> Integer.digits()
    |> Enum.split(-2)
    |> then(fn {dollar, cents} ->
      "$#{Enum.join(dollar)}.#{Enum.join(cents)}"
    end)
  end

  def crash do
    Phoenix.PubSub.broadcast(StockPriceListener.PubSub, "amz", "crash")
  end
end
