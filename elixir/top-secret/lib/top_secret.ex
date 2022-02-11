defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc \\ [])

  def decode_secret_message_part({op, _data, [fun | _]} = ast, acc)
      when op == :def or op == :defp do
    fun =
      case fun do
        {:when, _data, args} ->
          List.first(args)

        fun ->
          fun
      end

    arity = get_fun_arity(fun)

    name =
      fun
      |> elem(0)
      |> Atom.to_string()
      |> trim_to_length(arity)

    {ast, [name | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)

    do_decode_secret_message(ast, [])
    |> assemble_message()
  end

  defp do_decode_secret_message({:__block__, _data, ast_list}, acc) do
    do_decode_secret_message(ast_list, acc)
  end

  defp do_decode_secret_message({:defmodule, _data, args}, acc) do
    args
    |> Enum.fetch!(1)
    |> Keyword.get(:do)
    |> do_decode_secret_message(acc)
  end

  defp do_decode_secret_message([], acc), do: acc

  defp do_decode_secret_message([{:defmodule, _, _} = ast | ast_list], acc) do
    acc = do_decode_secret_message(ast, acc)
    do_decode_secret_message(ast_list, acc)
  end

  defp do_decode_secret_message([ast | ast_list], acc) do
    {_, acc} = decode_secret_message_part(ast, acc)
    do_decode_secret_message(ast_list, acc)
  end

  defp do_decode_secret_message(ast, acc) do
    {_, acc} = decode_secret_message_part(ast, acc)
    acc
  end

  defp get_fun_arity({_fun, _data, nil}), do: 0
  defp get_fun_arity({_fun, _data, args}), do: length(args)

  defp trim_to_length(_string, 0), do: ""

  defp trim_to_length(string, len) do
    String.slice(string, 0..(len - 1))
  end

  defp assemble_message(msg_parts) do
    msg_parts
    |> Enum.reverse()
    |> Enum.join()
  end
end
