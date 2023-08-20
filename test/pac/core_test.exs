defmodule Pac.CoreTest do
  use Pac.DataCase

  alias Pac.Core

  describe "documents" do
    alias Pac.Core.Document

    import Pac.CoreFixtures

    @invalid_attrs %{name: nil}

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Core.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Core.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Document{} = document} = Core.create_document(valid_attrs)
      assert document.name == "some name"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Document{} = document} = Core.update_document(document, update_attrs)
      assert document.name == "some updated name"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_document(document, @invalid_attrs)
      assert document == Core.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Core.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Core.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Core.change_document(document)
    end
  end

  describe "contacts" do
    alias Pac.Core.Contact

    import Pac.CoreFixtures

    @invalid_attrs %{name: nil, phone_number: nil}

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Core.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Core.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      valid_attrs = %{name: "some name", phone_number: "some phone_number"}

      assert {:ok, %Contact{} = contact} = Core.create_contact(valid_attrs)
      assert contact.name == "some name"
      assert contact.phone_number == "some phone_number"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      update_attrs = %{name: "some updated name", phone_number: "some updated phone_number"}

      assert {:ok, %Contact{} = contact} = Core.update_contact(contact, update_attrs)
      assert contact.name == "some updated name"
      assert contact.phone_number == "some updated phone_number"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_contact(contact, @invalid_attrs)
      assert contact == Core.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Core.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Core.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Core.change_contact(contact)
    end
  end

  describe "messages" do
    alias Pac.Core.Message

    import Pac.CoreFixtures

    @invalid_attrs %{content: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Core.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Core.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Message{} = message} = Core.create_message(valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Message{} = message} = Core.update_message(message, update_attrs)
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_message(message, @invalid_attrs)
      assert message == Core.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Core.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Core.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Core.change_message(message)
    end
  end

  describe "attachments" do
    alias Pac.Core.Attachment

    import Pac.CoreFixtures

    @invalid_attrs %{name: nil}

    test "list_attachments/0 returns all attachments" do
      attachment = attachment_fixture()
      assert Core.list_attachments() == [attachment]
    end

    test "get_attachment!/1 returns the attachment with given id" do
      attachment = attachment_fixture()
      assert Core.get_attachment!(attachment.id) == attachment
    end

    test "create_attachment/1 with valid data creates a attachment" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Attachment{} = attachment} = Core.create_attachment(valid_attrs)
      assert attachment.name == "some name"
    end

    test "create_attachment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_attachment(@invalid_attrs)
    end

    test "update_attachment/2 with valid data updates the attachment" do
      attachment = attachment_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Attachment{} = attachment} = Core.update_attachment(attachment, update_attrs)
      assert attachment.name == "some updated name"
    end

    test "update_attachment/2 with invalid data returns error changeset" do
      attachment = attachment_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_attachment(attachment, @invalid_attrs)
      assert attachment == Core.get_attachment!(attachment.id)
    end

    test "delete_attachment/1 deletes the attachment" do
      attachment = attachment_fixture()
      assert {:ok, %Attachment{}} = Core.delete_attachment(attachment)
      assert_raise Ecto.NoResultsError, fn -> Core.get_attachment!(attachment.id) end
    end

    test "change_attachment/1 returns a attachment changeset" do
      attachment = attachment_fixture()
      assert %Ecto.Changeset{} = Core.change_attachment(attachment)
    end
  end
end
