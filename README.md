# Stock Price Listener System

This project implements a distributed stock price listener system using **Elixir** technologies such as `GenServer`, `Agent`, `libcluster`, and `Phoenix.PubSub`.

It also includes a stock price **generator** that simulates an external service sending price updates. When a price is received, it is propagated to all subscribed users in real time.

### Features

* Users can **subscribe** and **unsubscribe** to individual stock tickers or all at once.
* Supports **crash simulation** to test fault tolerance and automatic recovery.
* On recovery, the system **restores previous subscriptions**.
* Distributed across multiple nodes using `libcluster`.

### Available Stock Tickers

```
FB, AMZ, AAPL, NVDA, GOOG
```

---

## Getting Started

### 1. Install Dependencies

Install [asdf](https://asdf-vm.com/) and run:

```bash
asdf install
```

### 2. Start the Cluster

Open **four** terminal instances and run the following commands in each:

```bash
iex --name node1@127.0.0.1 -S mix
iex --name node2@127.0.0.1 -S mix
iex --name node3@127.0.0.1 -S mix
iex --name node4@127.0.0.1 -S mix
```

> Ensure `epmd` is running and nodes can connect via Erlang distribution.

---

## Usage

### Subscribe to Stock Tickers

```elixir
StockPriceListenerClient.subscribe("AMZ")
StockPriceListenerClient.subscribe_all()
```

### Unsubscribe from Stock Tickers

```elixir
StockPriceListenerClient.unsubscribe("GOOG")
StockPriceListenerClient.unsubscribe_all()
```

### Start the Price Generator

```elixir
{:ok, pid} = GenServer.start(StockPriceGenerator, 5000)
# The number is the update interval in milliseconds
```

### Stop the Generator

```elixir
GenServer.stop(pid)
```

### Simulate a Crash

```elixir
StockPriceListenerServer.crash()
```

> At least one user must be subscribed to `"AMZ"` for the crash to be meaningful.

### Manually Broadcast a Stock Price

```elixir
Phoenix.PubSub.broadcast(StockPriceListener.PubSub, "AAPL", {"AAPL", 31245})
```

---

## Notes

* The system demonstrates how to build a resilient Elixir application that can handle failures and recover gracefully.
* Useful for learning supervision trees, clustering, process recovery, and real-time messaging.
