defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    cond do
      silent?(input) ->
        "Fine. Be that way!"

      yelling_question?(input) ->
        "Calm down, I know what I'm doing!"

      yelling?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  # Tests if string has atleast one letter and all letters are
  # upper case.
  defp yelling?(str) do
    upcase = String.upcase(str)
    str == upcase and upcase != String.downcase(str)
  end

  defp question?(str) do
    String.ends_with?(str, "?")
  end

  defp yelling_question?(str) do
    yelling?(str) and question?(str)
  end

  defp silent?(""), do: true
  defp silent?(_), do: false
end
