defmodule Matrix do
  defstruct matrix: %{}

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    matrix =
      input
      |> String.split("\n")
      |> Enum.map(&row_from_string/1)
      |> list_to_index_map()

    %__MODULE__{matrix: matrix}
  end

  defp row_from_string(string) do
    string
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> list_to_index_map()
  end

  defp list_to_index_map(list) do
    list
    |> Enum.with_index(1)
    |> Enum.into(%{}, fn {el, i} -> {i, el} end)
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%__MODULE__{} = matrix) do
    matrix.matrix
    |> Map.keys()
    |> Enum.map(&row(matrix, &1))
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    matrix.matrix
    |> get_in([index])
    |> Map.to_list()
    |> Enum.map(fn {k, v} -> v end)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
  end
end
