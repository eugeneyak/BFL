defmodule Bfl.AccountsTest do
  use Bfl.DataCase

  alias Bfl.Accounts

  describe "oauth" do
    alias Bfl.Accounts.OAuth

    @valid_attrs %Ueberauth.Auth.Info{email: "email@example.com"}
    @invalid_attrs %Ueberauth.Auth.Info{email: nil}

    def oauth_fixture(attrs \\ %{}) do
      {:ok, oauth} = Accounts.create_oauth(:github, Enum.into(attrs, @valid_attrs))
      oauth
    end

    test "create_oauth/1 with valid data creates a o_auth" do
      assert {:ok, %OAuth{} = oauth} = Accounts.create_oauth(:github, @valid_attrs)
      assert oauth.email == "email@example.com"
      assert oauth.provider == "github"
    end

    test "create_oauth/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_oauth(:github, @invalid_attrs)
    end

    @tag :skip
    test "delete_o_auth/1 deletes the o_auth" do
      o_auth = oauth_fixture()
      assert {:ok, %OAuth{}} = Accounts.delete_oauth(o_auth)
    end
  end
end
