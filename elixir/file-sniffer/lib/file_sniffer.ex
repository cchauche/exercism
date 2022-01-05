defmodule FileSniffer do
  @mime_types %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }
  def type_from_extension(extension), do: @mime_types[extension]

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _body::binary>>),
    do: @mime_types["exe"]

  def type_from_binary(<<0x42, 0x4D, _body::binary>>),
    do: @mime_types["bmp"]

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _body::binary>>),
    do: @mime_types["png"]

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _body::binary>>),
    do: @mime_types["jpg"]

  def type_from_binary(<<0x47, 0x49, 0x46, _body::binary>>),
    do: @mime_types["gif"]

  def verify(file_binary, extension) do
    extension_type = type_from_extension(extension)
    file_type = type_from_binary(file_binary)

    case file_type == extension_type do
      true ->
        {:ok, extension_type}

      _ ->
        {:error, "Warning, file format and file extension do not match."}
    end
  end
end
