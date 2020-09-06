defmodule Bfl.RegistryTest do
  use Bfl.DataCase

  alias Bfl.Registry

  describe "bookmarks" do
    alias Bfl.Registry.Bookmark

    @valid_attrs %{title: "some title", url: "some url"}
    @update_attrs %{title: "some updated title", url: "some updated url"}
    @invalid_attrs %{title: nil, url: nil}

    def bookmark_fixture(attrs \\ %{}) do
      {:ok, bookmark} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Registry.create_bookmark()

      bookmark
    end

    test "list_bookmarks/0 returns all bookmarks" do
      bookmark = bookmark_fixture()
      assert Registry.list_bookmarks() == [bookmark]
    end

    test "get_bookmark!/1 returns the bookmark with given id" do
      bookmark = bookmark_fixture()
      assert Registry.get_bookmark!(bookmark.id) == bookmark
    end

    test "create_bookmark/1 with valid data creates a bookmark" do
      assert {:ok, %Bookmark{} = bookmark} = Registry.create_bookmark(@valid_attrs)
      assert bookmark.title == "some title"
      assert bookmark.url == "some url"
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registry.create_bookmark(@invalid_attrs)
    end

    test "update_bookmark/2 with valid data updates the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{} = bookmark} = Registry.update_bookmark(bookmark, @update_attrs)
      assert bookmark.title == "some updated title"
      assert bookmark.url == "some updated url"
    end

    test "update_bookmark/2 with invalid data returns error changeset" do
      bookmark = bookmark_fixture()
      assert {:error, %Ecto.Changeset{}} = Registry.update_bookmark(bookmark, @invalid_attrs)
      assert bookmark == Registry.get_bookmark!(bookmark.id)
    end

    test "delete_bookmark/1 deletes the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{}} = Registry.delete_bookmark(bookmark)
      assert_raise Ecto.NoResultsError, fn -> Registry.get_bookmark!(bookmark.id) end
    end

    test "change_bookmark/1 returns a bookmark changeset" do
      bookmark = bookmark_fixture()
      assert %Ecto.Changeset{} = Registry.change_bookmark(bookmark)
    end
  end
end
