defmodule PacWeb.AttachmentLiveTest do
  use PacWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pac.CoreFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_attachment(_) do
    attachment = attachment_fixture()
    %{attachment: attachment}
  end

  describe "Index" do
    setup [:create_attachment]

    test "lists all attachments", %{conn: conn, attachment: attachment} do
      {:ok, _index_live, html} = live(conn, ~p"/attachments")

      assert html =~ "Listing Attachments"
      assert html =~ attachment.name
    end

    test "saves new attachment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/attachments")

      assert index_live |> element("a", "New Attachment") |> render_click() =~
               "New Attachment"

      assert_patch(index_live, ~p"/attachments/new")

      assert index_live
             |> form("#attachment-form", attachment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#attachment-form", attachment: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/attachments")

      html = render(index_live)
      assert html =~ "Attachment created successfully"
      assert html =~ "some name"
    end

    test "updates attachment in listing", %{conn: conn, attachment: attachment} do
      {:ok, index_live, _html} = live(conn, ~p"/attachments")

      assert index_live |> element("#attachments-#{attachment.id} a", "Edit") |> render_click() =~
               "Edit Attachment"

      assert_patch(index_live, ~p"/attachments/#{attachment}/edit")

      assert index_live
             |> form("#attachment-form", attachment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#attachment-form", attachment: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/attachments")

      html = render(index_live)
      assert html =~ "Attachment updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes attachment in listing", %{conn: conn, attachment: attachment} do
      {:ok, index_live, _html} = live(conn, ~p"/attachments")

      assert index_live |> element("#attachments-#{attachment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#attachments-#{attachment.id}")
    end
  end

  describe "Show" do
    setup [:create_attachment]

    test "displays attachment", %{conn: conn, attachment: attachment} do
      {:ok, _show_live, html} = live(conn, ~p"/attachments/#{attachment}")

      assert html =~ "Show Attachment"
      assert html =~ attachment.name
    end

    test "updates attachment within modal", %{conn: conn, attachment: attachment} do
      {:ok, show_live, _html} = live(conn, ~p"/attachments/#{attachment}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Attachment"

      assert_patch(show_live, ~p"/attachments/#{attachment}/show/edit")

      assert show_live
             |> form("#attachment-form", attachment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#attachment-form", attachment: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/attachments/#{attachment}")

      html = render(show_live)
      assert html =~ "Attachment updated successfully"
      assert html =~ "some updated name"
    end
  end
end
