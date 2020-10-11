defmodule Bfl.AccountsTest do
  use Bfl.DataCase

  alias Bfl.Accounts

  describe "user" do
    alias Bfl.Accounts.User

    @valid_attrs %Ueberauth.Auth.Info{email: "email@example.com", name: "Name"}
    @invalid_attrs %Ueberauth.Auth.Info{email: nil}

    def user_fixture do
      {:ok, user} = Accounts.create_user(@valid_attrs)
      IO.inspect(user)
      user
    end

    test "create_user/1 with valid data creates a o_auth" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "email@example.com"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
