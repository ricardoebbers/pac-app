defmodule Pac.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pac.Core` context.
  """

  @doc """
  Generate a document.
  """
  def document_fixture(attrs \\ %{}) do
    {:ok, document} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Pac.Core.create_document()

    document
  end

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        name: "some name",
        phone_number: "some phone_number"
      })
      |> Pac.Core.create_contact()

    contact
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> Pac.Core.create_message()

    message
  end

  @doc """
  Generate a attachment.
  """
  def attachment_fixture(attrs \\ %{}) do
    {:ok, attachment} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Pac.Core.create_attachment()

    attachment
  end
end
