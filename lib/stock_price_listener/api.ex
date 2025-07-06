defmodule StockPriceListener.Api do
  @moduledoc """
  API for interacting with the StockPriceListener server.
  """

  @doc """
  Subscribes to a specific stock ticker.
  """
  @spec subscribe(String.t()) :: String.t()
  def subscribe(ticker) do
    call({:subscribe, ticker})
  end

  @doc """
  Subscribes to all stock tickers.
  """
  @spec subscribe_all() :: String.t()
  def subscribe_all do
    call(:subscribe_all)
  end

  @doc """
  Unsubscribes from a specific stock ticker.
  """
  @spec unsubscribe(String.t()) :: String.t()
  def unsubscribe(ticker) do
    call({:unsubscribe, ticker})
  end

  @doc """
  Unsubscribes from all stock tickers.
  """
  @spec unsubscribe_all() :: String.t()
  def unsubscribe_all do
    call(:unsubscribe_all)
  end

  defp call(args) do
    apply(GenServer, :call, [StockPriceListener, args])
  end
end
