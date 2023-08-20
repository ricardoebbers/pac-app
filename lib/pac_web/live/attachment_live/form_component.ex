defmodule PacWeb.AttachmentLive.FormComponent do
  use PacWeb, :live_component

  alias Pac.Core

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage attachment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="attachment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Attachment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{attachment: attachment} = assigns, socket) do
    changeset = Core.change_attachment(attachment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"attachment" => attachment_params}, socket) do
    changeset =
      socket.assigns.attachment
      |> Core.change_attachment(attachment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"attachment" => attachment_params}, socket) do
    save_attachment(socket, socket.assigns.action, attachment_params)
  end

  defp save_attachment(socket, :edit, attachment_params) do
    case Core.update_attachment(socket.assigns.attachment, attachment_params) do
      {:ok, attachment} ->
        notify_parent({:saved, attachment})

        {:noreply,
         socket
         |> put_flash(:info, "Attachment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_attachment(socket, :new, attachment_params) do
    case Core.create_attachment(attachment_params) do
      {:ok, attachment} ->
        notify_parent({:saved, attachment})

        {:noreply,
         socket
         |> put_flash(:info, "Attachment created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
