# Stock Price Listener System

This project implements a distributed stock price listener system using **Elixir**. It leverages `GenServer`, `Agent`, `Libcluster`, and `PubSub` to provide real-time stock price updates to subscribed users across a cluster of nodes.

### Features

* **Simulated Stock Price Feed**: A generator mimics an external service sending stock price updates to the system.
* **Subscription Management**: Users can subscribe and unsubscribe to stock tickers of their choice.
* **PubSub Event Broadcasting**: Once a price update is received, it is broadcast to all subscribed users.
* **Fault Tolerance**: You can simulate a crash in a user session to test fault tolerance and error recovery. After a process restarts, previously subscribed topics are automatically restored.

---

## Getting Started

### 1. Install Dependencies

Ensure you have [`asdf`](https://asdf-vm.com/) installed. Then run:

```bash
asdf install
```

### 2. Start Multiple Nodes

Open **four** separate terminal windows, tabs, or panes and start an `iex` session on each with the following commands:

```bash
iex --name node1@127.0.0.1 -S mix
iex --name node2@127.0.0.1 -S mix
iex --name node3@127.0.0.1 -S mix
iex --name node4@127.0.0.1 -S mix
```

The nodes will automatically connect via `libcluster`.

### 3. Use the Client

You can interact with the system using functions from the `StockPriceListener.Client` module.

Example:

```elixir
StockPriceListener.Client.subscribe("AAPL")
StockPriceListener.Client.unsubscribe("AAPL")
```

---

## Notes

* This is a proof-of-concept project focused on demonstrating distributed communication, state recovery, and real-time event propagation using Elixir's powerful concurrency model.