defmodule Bfl.RegistryTest do
  use Bfl.DataCase, async: true

  alias Bfl.Registry

  # describe "bookmarks" do
  #   alias Bfl.Registry.Bookmark

  #   @valid_attrs %{title: "some title", url: "some url"}
  #   @update_attrs %{title: "some updated title", url: "some updated url"}
  #   @invalid_attrs %{title: nil, url: nil}

  #   def bookmark_fixture(attrs \\ %{}) do
  #     {:ok, bookmark} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Registry.create_bookmark()

  #     bookmark
  #   end

  #   test "list_bookmarks/0 returns all bookmarks" do
  #     bookmark = bookmark_fixture()
  #     assert Registry.list_bookmarks() == [bookmark]
  #   end

  #   test "get_bookmark!/1 returns the bookmark with given id" do
  #     bookmark = bookmark_fixture()
  #     assert Registry.get_bookmark!(bookmark.id) == bookmark
  #   end

  #   test "create_bookmark/1 with valid data creates a bookmark" do
  #     assert {:ok, %Bookmark{} = bookmark} = Registry.create_bookmark(@valid_attrs)
  #     assert bookmark.title == "some title"
  #     assert bookmark.url == "some url"
  #   end

  #   test "create_bookmark/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Registry.create_bookmark(@invalid_attrs)
  #   end

  #   test "update_bookmark/2 with valid data updates the bookmark" do
  #     bookmark = bookmark_fixture()
  #     assert {:ok, %Bookmark{} = bookmark} = Registry.update_bookmark(bookmark, @update_attrs)
  #     assert bookmark.title == "some updated title"
  #     assert bookmark.url == "some updated url"
  #   end

  #   test "update_bookmark/2 with invalid data returns error changeset" do
  #     bookmark = bookmark_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Registry.update_bookmark(bookmark, @invalid_attrs)
  #     assert bookmark == Registry.get_bookmark!(bookmark.id)
  #   end

  #   test "delete_bookmark/1 deletes the bookmark" do
  #     bookmark = bookmark_fixture()
  #     assert {:ok, %Bookmark{}} = Registry.delete_bookmark(bookmark)
  #     assert_raise Ecto.NoResultsError, fn -> Registry.get_bookmark!(bookmark.id) end
  #   end

  #   test "change_bookmark/1 returns a bookmark changeset" do
  #     bookmark = bookmark_fixture()
  #     assert %Ecto.Changeset{} = Registry.change_bookmark(bookmark)
  #   end
  # end

  describe "collections" do
    alias Bfl.Registry.Collection

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    setup do
      [
        user: Bfl.Factory.insert(:user),
        collection: Bfl.Factory.insert(:collection) |> Repo.forget(:user)
      ]
    end

    test "list_collections/0 returns all collections", %{user: user, collection: collection} do
      assert Registry.list_collections() == [collection]
    end

    test "list_collections/1 returns all user's collections", %{user: user} do
      _other_collection = Bfl.Factory.insert(:collection) |> Repo.forget(:user)

      collection_1 =
        Bfl.Factory.insert(:collection,
          user: user,
          inserted_at: DateTime.add(DateTime.utc_now(), -3600, :second)
        )
        |> Repo.forget(:user)

      collection_2 =
        Bfl.Factory.insert(:collection, user: user)
        |> Repo.forget(:user)

      assert Registry.list_collections(user) == [collection_1, collection_2]
    end

    test "create_collection/1 with valid data creates a collection", %{user: user} do
      assert {:ok, %Collection{} = collection} = Registry.create_collection(@valid_attrs, user)
      assert collection.title == "some title"
      assert collection.user_id == user.id
    end

    test "create_collection/1 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Registry.create_collection(@invalid_attrs, user)
    end

    test "update_collection/2 with valid data updates the collection", %{collection: collection} do
      assert {:ok, %Collection{} = collection} =
               Registry.update_collection(collection, @update_attrs)

      assert collection.title == "some updated title"
    end

    test "update_collection/2 with invalid data returns error changeset", %{
      collection: collection
    } do
      assert {:error, %Ecto.Changeset{}} = Registry.update_collection(collection, @invalid_attrs)
    end

    test "delete_collection/1 deletes the collection", %{collection: collection} do
      assert {:ok, %Collection{}} = Registry.delete_collection(collection)
      assert Registry.list_collections() == []
    end

    test "change_collection/1 returns a collection changeset", %{collection: collection} do
      assert %Ecto.Changeset{} = Registry.change_collection(collection)
    end
  end

  # describe "redirects" do
  #   alias Bfl.Registry.Redirect

  #   @valid_attrs %{}
  #   @update_attrs %{}
  #   @invalid_attrs %{}

  #   def redirect_fixture(attrs \\ %{}) do
  #     {:ok, redirect} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Registry.create_redirect()

  #     redirect
  #   end

  #   test "list_redirects/0 returns all redirects" do
  #     redirect = redirect_fixture()
  #     assert Registry.list_redirects() == [redirect]
  #   end

  #   test "get_redirect!/1 returns the redirect with given id" do
  #     redirect = redirect_fixture()
  #     assert Registry.get_redirect!(redirect.id) == redirect
  #   end

  #   test "create_redirect/1 with valid data creates a redirect" do
  #     assert {:ok, %Redirect{} = redirect} = Registry.create_redirect(@valid_attrs)
  #   end

  #   test "create_redirect/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Registry.create_redirect(@invalid_attrs)
  #   end

  #   test "update_redirect/2 with valid data updates the redirect" do
  #     redirect = redirect_fixture()
  #     assert {:ok, %Redirect{} = redirect} = Registry.update_redirect(redirect, @update_attrs)
  #   end

  #   test "update_redirect/2 with invalid data returns error changeset" do
  #     redirect = redirect_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Registry.update_redirect(redirect, @invalid_attrs)
  #     assert redirect == Registry.get_redirect!(redirect.id)
  #   end

  #   test "delete_redirect/1 deletes the redirect" do
  #     redirect = redirect_fixture()
  #     assert {:ok, %Redirect{}} = Registry.delete_redirect(redirect)
  #     assert_raise Ecto.NoResultsError, fn -> Registry.get_redirect!(redirect.id) end
  #   end

  #   test "change_redirect/1 returns a redirect changeset" do
  #     redirect = redirect_fixture()
  #     assert %Ecto.Changeset{} = Registry.change_redirect(redirect)
  #   end
  # end
end
