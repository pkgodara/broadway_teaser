defmodule BroadwayTeaser.Producer do
  use GenStage
  require Logger

  def start_link(init_number \\ 0) do
    GenStage.start_link(__MODULE__, init_number, name: __MODULE__)
  end

  def init(counter) do
    {:producer, counter}
  end

  def handle_demand(demand, counter_state) when demand > 0 do
    sep = "\n\n---------------------####################---------------------\n\n"
    IO.puts sep
    IO.inspect demand, label: "*** received demand"

    Process.sleep 20000

    nums = Enum.to_list(counter_state..counter_state + demand-1)

    IO.puts "*** === fullfilling demand"
    {:noreply, nums, counter_state + demand}
  end
end