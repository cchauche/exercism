defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A ->
        0b0001

      ?C ->
        0b0010

      ?G ->
        0b0100

      ?T ->
        0b1000

      ?\s ->
        0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 ->
        ?A

      0b0010 ->
        ?C

      0b0100 ->
        ?G

      0b1000 ->
        ?T

      0b0000 ->
        ?\s
    end
  end

  def encode(dna) do
    do_encode(dna, "")
  end

  defp do_encode([], bitstring), do: bitstring

  defp do_encode([char | t], bitstring) do
    encoded = encode_nucleotide(char)
    bitstring = <<bitstring::bitstring, encoded::4>>
    do_encode(t, bitstring)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_decode(<<>>, charlist), do: charlist

  defp do_decode(<<nuc::4, t::bitstring>>, charlist) do
    decoded = decode_nucleotide(nuc)
    do_decode(t, charlist ++ [decoded])
  end
end
