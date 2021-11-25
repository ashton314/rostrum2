defmodule Rostrum.MeetingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rostrum.Meetings` context.
  """

  @doc """
  Generate a meeting.
  """
  def meeting_fixture(attrs \\ %{}) do
    {:ok, meeting} =
      attrs
      |> Enum.into(%{
        date: ~N[2021-11-24 04:22:00],
        title: "some title"
      })
      |> Rostrum.Meetings.create_meeting()

    meeting
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        hymn: 42,
        note: "some note",
        order: 42,
        participants: "some participants",
        title: "some title",
        type: :hymn
      })
      |> Rostrum.Meetings.create_event()

    event
  end
end
