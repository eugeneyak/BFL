defmodule Bfl.Cache.Manager do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def fetch(key, value) do
    GenServer.call(__MODULE__, {:fetch, key, value})
  end

  @impl true
  def init(_) do
    {:ok, %{}, {:continue, :trap}}
  end

  @impl true
  def handle_continue(:trap, state) do
    Process.flag(:trap_exit, true)

    {:noreply, state}
  end

  @impl true
  def handle_call({:set, key, value}, _from, state) do
    {:ok, pid} = GenServer.start_link(Bfl.Cache.Agent, value)
    {:reply, :ok, Map.put(state, key, pid)}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    case Map.fetch(state, key) do
      {:ok, pid} -> {:reply, GenServer.call(pid, :get), state}
      :error -> {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:fetch, key, value}, _from, state) do
    case Map.fetch(state, key) do
      {:ok, pid} ->
        {:reply, GenServer.call(pid, :get), state}

      :error ->
        {:ok, pid} = GenServer.start_link(Bfl.Cache.Agent, value)
        {:reply, value, Map.put(state, key, pid)}
    end
  end

  @impl true
  def handle_info({:EXIT, pid, :normal}, state) do
    case List.keyfind(Map.to_list(state), pid, 1) do
      {key, _pid} -> {:noreply, Map.delete(state, key)}
      nil -> {:noreply, state}
    end
  end
end
