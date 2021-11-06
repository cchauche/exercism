defmodule SecretHandshake do
  import Bitwise, only: [&&&: 2]

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

      1 = wink
     10 = double blink
    100 = close your eyes
   1000 = jump
  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> wink?(code)
    |> double_blink?(code)
    |> close_your_eyes?(code)
    |> jump?(code)
    |> reverse?(code)
  end

  def wink?(handshake, code) do
    if (code &&& 1) == 1 do
      handshake ++ ["wink"]
    else
      handshake
    end
  end

  def double_blink?(handshake, code) do
    if (code &&& 2) == 2 do
      handshake ++ ["double blink"]
    else
      handshake
    end
  end

  def close_your_eyes?(handshake, code) do
    if (code &&& 4) == 4 do
      handshake ++ ["close your eyes"]
    else
      handshake
    end
  end

  def jump?(handshake, code) do
    if (code &&& 8) == 8 do
      handshake ++ ["jump"]
    else
      handshake
    end
  end

  def reverse?(handshake, code) do
    if (code &&& 16) == 16 do
      Enum.reverse(handshake)
    else
      handshake
    end
  end
end
