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

    arity =
      fun
      |> get_fun_arity()

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

    ast_list =
      case ast do
        {:defmodule, _, args} ->
          args
          |> elem(1)
          |> Keyword.get(:do)

        {:__block__, _, args} ->
          args
      end

    do_decode_secret_message(ast_list, [])
  end

  defp do_decode_secret_message([], acc), do: acc

  defp do_decode_secret_message([arg | args], acc) do
    {_, acc} = decode_secret_message_part(arg, acc)
    do_decode_secret_message(args, acc)
  end

  defp get_fun_arity({_fun, _data, nil}), do: 0
  defp get_fun_arity({_fun, _data, args}), do: length(args)

  defp trim_to_length(_string, 0), do: ""

  defp trim_to_length(string, len) do
    String.slice(string, 0..(len - 1))
  end
end

# {:defmodule, [line: 1],
#  [
#    {:__aliases__, [line: 1], [:MyCalendar]},
#    [
#      do:
#        {:__block__, [],
#         [
#           {:def, [line: 2],
#            [
#              {:busy?, [line: 2], [{:date, [line: 2], nil}, {:time, [line: 2], nil}]},
#              [
#                do:
#                  {:and, [line: 3],
#                   [
#                     {:!=, [line: 3],
#                      [
#                        {{:., [line: 3], [{:__aliases__, [line: 3], [:Date]}, :day_of_week]},
#                         [line: 3], [{:date, [line: 3], nil}]},
#                        7
#                      ]},
#                     {:in, [line: 4],
#                      [
#                        {{:., [line: 4], [{:time, [line: 4], nil}, :hour]},
#                         [no_parens: true, line: 4], []},
#                        {:.., [line: 4], [10, 16]}
#                      ]}
#                   ]}
#              ]
#            ]},
#           {:def, [line: 7],
#            [
#              {:yesterday?, [line: 7], [{:date, [line: 7], nil}]},
#              [
#                do:
#                  {{:., [line: 8], [{:__aliases__, [line: 8], [:Date]}, :diff]}, [line: 8],
#                   [
#                     {{:., [line: 8], [{:__aliases__, [line: 8], [:Date]}, :utc_today]},
#                      [no_parens: true, line: 8], []},
#                     {:date, [line: 8], nil}
#                   ]}
#              ]
#            ]}
#         ]}
#    ]
#  ]}
