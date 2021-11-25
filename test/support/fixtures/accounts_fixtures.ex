defmodule Rostrum.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rostrum.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Rostrum.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a unit.
  """
  def unit_fixture(attrs \\ %{}) do
    {:ok, unit} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Rostrum.Accounts.create_unit()

    unit
  end

  @doc """
  Generate a settings.
  """
  def settings_fixture(attrs \\ %{}) do
    {:ok, settings} =
      attrs
      |> Enum.into(%{
        active: true,
        contact_email: "some contact_email",
        public: true
      })
      |> Rostrum.Accounts.create_settings()

    settings
  end
end
