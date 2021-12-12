defmodule HighSchoolSweetheart do
  def first_letter(name) do
    {ltr, _} = name |> String.trim() |> String.next_grapheme()
    ltr
  end

  def initial(name) do
    init =
      name
      |> first_letter()
      |> String.upcase()

    init <> "."
  end

  def initials(full_name) do
    full_name
    |> String.split(" ")
    |> Enum.map(&HighSchoolSweetheart.initial/1)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    init1 = initials(full_name1)
    init2 = initials(full_name2)

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{init1}  +  #{init2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """

    # Please implement the pair/2 function
  end
end
