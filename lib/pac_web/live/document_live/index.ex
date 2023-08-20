defmodule PacWeb.DocumentLive.Index do
  use PacWeb, :live_view

  alias Pac.Core
  alias Pac.Core.Document

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :documents, Core.list_documents())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Document")
    |> assign(:document, Core.get_document!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Document")
    |> assign(:document, %Document{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Documents")
    |> assign(:document, nil)
  end

  @impl true
  def handle_info({PacWeb.DocumentLive.FormComponent, {:saved, document}}, socket) do
    {:noreply, stream_insert(socket, :documents, document)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    document = Core.get_document!(id)
    {:ok, _} = Core.delete_document(document)

    {:noreply, stream_delete(socket, :documents, document)}
  end
end
