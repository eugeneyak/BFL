defmodule Bfl.Factory do
  use ExMachina.Ecto, repo: Bfl.Repo

  def user_factory do
    %Bfl.Accounts.User{
      name: "Jane Smith",
      email: sequence(:email, &"email.#{&1}@example.com")
    }
  end

  def collection_factory do
    %Bfl.Registry.Collection{
      user: build(:user),
      title: sequence(:email, &"Title #{&1}"),
      bookmarks: []
    }
  end
end
