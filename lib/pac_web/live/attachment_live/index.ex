defmodule PacWeb.AttachmentLive.Index do
  use PacWeb, :live_view

  alias Pac.Core
  alias Pac.Core.Attachment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :attachments, Core.list_attachments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Attachment")
    |> assign(:attachment, Core.get_attachment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Attachment")
    |> assign(:attachment, %Attachment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Attachments")
    |> assign(:attachment, nil)
  end

  @impl true
  def handle_info({PacWeb.AttachmentLive.FormComponent, {:saved, attachment}}, socket) do
    {:noreply, stream_insert(socket, :attachments, attachment)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    attachment = Core.get_attachment!(id)
    {:ok, _} = Core.delete_attachment(attachment)

    {:noreply, stream_delete(socket, :attachments, attachment)}
  end
end
