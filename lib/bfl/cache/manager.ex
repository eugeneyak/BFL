defmodule Bfl.Cache.Manager do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def add(key, value) do
    GenServer.call(__MODULE__, {:add, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  @impl true
  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  @impl true
  def handle_call({:add, key, value}, _from, state) do
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
  def handle_info({:EXIT, pid, :normal}, state) do
    {key, _pid} =
      state
      |> Map.to_list()
      |> List.keyfind(pid, 1)

    {:noreply, Map.delete(state, key)}
  end
end
