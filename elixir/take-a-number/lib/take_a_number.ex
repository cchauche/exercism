defmodule TakeANumber do
  def start() do
    spawn(fn ->
      loop(0)
    end)
  end

  defp loop(num) do
    receive do
      {:report_state, sender} ->
        send(sender, num)
        loop(num)

      {:take_a_number, sender} ->
        num = num + 1
        send(sender, num)
        loop(num)

      :stop ->
        nil

      _ ->
        loop(num)
    end
  end
end
