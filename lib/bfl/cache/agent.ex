defmodule Bfl.Cache.Agent do
  use GenServer

  @impl true
  def init(data, time \\ 5) do
    {:ok, %{data: data, time: time, timer: set_timer(time)}}
  end

  @impl true
  def handle_info(:kill, %{data: data}) do
    {:stop, :normal, %{data: data}}
  end

  @impl true
  def handle_call(:get, _from, %{data: data, time: time, timer: timer} = state) do
    Process.cancel_timer(timer)
    {:reply, data, %{state | timer: set_timer(time)}}
  end

  defp set_timer(time), do: Process.send_after(self(), :kill, time * 1000)
end
