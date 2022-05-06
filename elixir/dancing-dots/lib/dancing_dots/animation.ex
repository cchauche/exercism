defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: keyword()) :: {:ok, opts :: keyword()} | {:error, error :: any}
  @callback handle_frame(dot :: dot(), frame_number :: pos_integer(), opts :: keyword()) :: dot()

  defmacro __using__(_) do
    quote do
      alias DancingDots.Animation
      alias DancingDots.Dot
      @behaviour Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl Animation
  def handle_frame(%Dot{} = dot, frame_number, _opts) when rem(frame_number, 4) == 0 do
    %Dot{dot | opacity: dot.opacity / 2}
  end

  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl Animation
  def init(opts) do
    case opts[:velocity] do
      velocity when is_integer(velocity) ->
        {:ok, opts}

      value ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(value)}"}
    end
  end

  @impl Animation
  def handle_frame(%Dot{} = dot, frame_number, opts) do
    %Dot{dot | radius: dot.radius + (frame_number - 1) * opts[:velocity]}
  end
end
