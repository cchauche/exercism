defmodule Atbash do
  @alphabet "abcdefghijklmnopqrstuvwxyz" |> String.split("", trim: true)
  @reverse Enum.reverse(@alphabet)
  @encode_map Enum.zip_reduce(@alphabet, @reverse, %{}, fn char1, char2, acc ->
                Map.put_new(acc, char1, char2)
              end)
  @decode_map Enum.zip_reduce(@reverse, @alphabet, %{}, fn char1, char2, acc ->
                Map.put_new(acc, char1, char2)
              end)
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.replace(~r/\s|\W/, "")
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.map(&(@encode_map[&1] || &1))
    |> Enum.chunk_every(5)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(" ", "")
    |> String.split("", trim: true)
    |> Enum.map(&(@decode_map[&1] || &1))
    |> Enum.join()
  end
end
