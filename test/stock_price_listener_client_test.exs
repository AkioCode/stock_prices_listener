defmodule StockPriceListener.ClientTest do
  use ExUnit.Case

  alias StockPriceListener.Client

  test "subscribe/1 with valid ticker" do
    assert Client.subscribe("fb") == "Subscribed to FB updates"
  end

  test "subscribe/1 with invalid ticker" do
    assert Client.subscribe("tsla") == "TSLA not found!"
  end

  test "unsubscribe/1 with valid ticker" do
    StockPriceListener.Client.subscribe("amz")
    assert Client.unsubscribe("amz") == "Unsubscribed from AMZ updates"
  end

  test "unsubscribe/1 with invalid ticker" do
    assert Client.unsubscribe("tsla") == "TSLA not found!"
  end

  test "subscribe_all/0 subscribes to all tickers" do
    assert Client.subscribe_all() == "Subscribed to all"
  end

  test "unsubscribe_all/0 unsubscribes from all tickers" do
    StockPriceListener.Client.subscribe_all()
    assert Client.unsubscribe_all() == "Unsubscribed from all"
  end
end
