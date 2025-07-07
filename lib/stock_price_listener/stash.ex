defmodule StockPriceListener.Stash do
  @moduledoc """
  Module for storing and retrieving data in a separate process using Agent.
  This will allow us to keep data intact if the process crashes.
  """
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{"topics" => []} end, name: __MODULE__)
  end

  def put(key, value) do
    Agent.update(__MODULE__, &Map.put(&1, key, value))
  end

  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end
end
