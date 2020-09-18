defmodule Bfl.Cache.Cachier do
  @callback data(key :: term) :: {:ok, term} | :error

  defmacro __using__(_opts) do
    quote do
      use GenServer

      @behaviour Bfl.Cache.Cachier

      def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, opts, name: __MODULE__)
      end

      def fetch(key) do
        GenServer.call(__MODULE__, {:fetch, key})
      end

      @impl true
      def init(_), do: {:ok, %{}, {:continue, :trap}}

      @impl true
      def handle_continue(:trap, state) do
        Process.flag(:trap_exit, true)
        {:noreply, state}
      end

      @impl true
      def handle_call({:fetch, key}, _from, state) do
        case Map.fetch(state, key) do
          {:ok, pid} ->
            {:reply, GenServer.call(pid, :get), state}

          :error ->
            with {:ok, data} <- data(key),
                 {:ok, pid} <- GenServer.start_link(Bfl.Cache.Agent, data),
                 do: {:reply, data, Map.put(state, key, pid)}
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
  end
end
