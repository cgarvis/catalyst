defmodule Catalyst do
  @moduledoc """
  Documentation for `Catalyst`.
  """

  defmacro __using(_) do
    quote do
      import Catalyst.{Navbar}
    end
  end
end
