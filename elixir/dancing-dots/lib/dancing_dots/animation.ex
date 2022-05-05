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
      @behaviour Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl Animation
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0 do
    %{dot | opacity: dot.opacity / 2}
  end

  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  # Please implement the module
end
