defmodule StockPriceListener.ClientTest do
  use ExUnit.Case

  alias StockPriceListener.Client

  test "subscribe/1 with valid ticker" do
    assert Client.subscribe("FB") == "Subscribed to FB updates"
  end

  test "subscribe/1 with invalid ticker" do
    assert Client.subscribe("TSLA") == "TSLA not found!"
  end

  test "unsubscribe/1 with valid ticker" do
    StockPriceListener.Client.subscribe("AMZ")
    assert Client.unsubscribe("AMZ") == "Unsubscribed from AMZ updates"
  end

  test "unsubscribe/1 with invalid ticker" do
    assert Client.unsubscribe("TSLA") == "TSLA not found!"
  end

  test "subscribe_all/0 subscribes to all tickers" do
    assert Client.subscribe_all() == "Subscribed to all"
  end

  test "unsubscribe_all/0 unsubscribes from all tickers" do
    StockPriceListener.Client.subscribe_all()
    assert Client.unsubscribe_all() == "Unsubscribed from all"
  end
end
