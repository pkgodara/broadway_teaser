defmodule BroadwayTeaser.Pipeline do
  use Broadway
  require Integer

  alias Broadway.BatchInfo
  alias Broadway.Message

  def start_link(_arg) do
    Broadway.start_link(__MODULE__,
    name: __MODULE__,
    producer: [
      module: {BroadwayTeaser.Producer, 0},
      transformer: {BroadwayTeaser.Transformer, :transform, []},
      concurrency: 1,
      rate_limiting: [
          allowed_messages: 60,
          interval: 60_000
        ]
    ],
    processors: [
      default: [
        concurrency: 5
      ]
    ]
    )
  end

  @impl true
  # called by processors
  def handle_message(processor, message, _context) do
    IO.inspect message.data, label: "received by processor - " <> to_string(processor) <> ", +++ message"

    delay(message.data)

    IO.inspect message.data, label: "### processed by processor - " <> to_string(processor) <> ", message"

    message # return
  end

  defp delay(num) do
    if true == Integer.is_odd(num) do
      Process.sleep Enum.random(1000..1500)
    else
      Process.sleep Enum.random(100..200)
    end

    if rem(num, 5) == 0 do # delay 0,5,10... further
      Process.sleep 30000
    end
  end
end