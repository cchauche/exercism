defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {:ok, pid} = Task.start_link(fn -> calculator.(input) end)

    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)

      {:EXIT, ^pid, _} ->
        Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    trap_exit_value = Process.flag(:trap_exit, true)

    results =
      Enum.reduce(inputs, %{}, fn input, results ->
        start_reliability_check(calculator, input)
        |> await_reliability_check_result(results)
      end)

    Process.flag(:trap_exit, trap_exit_value)
    results
  end

  def correctness_check(calculator, inputs) do
    # Please implement the correctness_check/2 function
  end
end
