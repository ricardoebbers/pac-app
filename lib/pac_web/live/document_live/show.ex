defmodule PacWeb.DocumentLive.Show do
  use PacWeb, :live_view

  alias Pac.Core

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:document, Core.get_document!(id))}
  end

  defp page_title(:show), do: "Show Document"
  defp page_title(:edit), do: "Edit Document"
end
