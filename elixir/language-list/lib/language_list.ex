defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([_ | list]), do: list

  def first([el | _list]), do: el

  def count(list) do
    length(list)
  end

  def exciting_list?(list) do
    cond do
      "Elixir" in list ->
        true

      true ->
        false
    end
  end
end
