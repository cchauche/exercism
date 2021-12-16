defmodule NameBadge do
  def print(id, name, department) do
    id = if id, do: "[#{id}] - ", else: ""
    department = if department, do: department, else: "OWNER"

    id <> "#{name} - #{String.upcase(department)}"
  end
end
