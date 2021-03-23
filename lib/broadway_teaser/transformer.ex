defmodule BroadwayTeaser.Transformer do
  def transform(event, _opts) do
    %Broadway.Message{
      data: event,
      acknowledger: {__MODULE__, :ack_id, event}
    }
  end

  def ack(ref, _successes, _failures) do
    IO.inspect ref, label: "acknowledged!!!"
    :ok
  end
end