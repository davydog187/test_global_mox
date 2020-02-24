defmodule GlobalMox.Server do
  @moduledoc """
  Service that just keeps calling `GlobalMox.Interface.foo/1`

  This is intended to run in the Application supervision  tree to test
  interaction with Mox
  """
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, name: args[:name] || __MODULE__)
  end

  def init(:ok) do
    {:ok, :ok, {:continue, :call_interface}}
  end

  def handle_continue(:call_interface, _state) do
    GlobalMox.Interface.foo("hello")

    {:noreply, {:continue, :call_interface}}
  end
end