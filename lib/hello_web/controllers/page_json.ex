defmodule HelloWeb.PageJSON do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use HelloWeb, :html

  def home(_assigns) do
    %{message: "this is some json"}
  end
end
