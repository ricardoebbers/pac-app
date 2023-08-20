defmodule PacWeb.AttachmentLive.Show do
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
     |> assign(:attachment, Core.get_attachment!(id))}
  end

  defp page_title(:show), do: "Show Attachment"
  defp page_title(:edit), do: "Edit Attachment"
end
