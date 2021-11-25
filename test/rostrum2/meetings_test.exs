defmodule Rostrum.MeetingsTest do
  use Rostrum.DataCase

  alias Rostrum.Meetings

  describe "meetings" do
    alias Rostrum.Meetings.Meeting

    import Rostrum.MeetingsFixtures

    @invalid_attrs %{date: nil, title: nil}

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert Meetings.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()
      assert Meetings.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      valid_attrs = %{date: ~N[2021-11-24 04:22:00], title: "some title"}

      assert {:ok, %Meeting{} = meeting} = Meetings.create_meeting(valid_attrs)
      assert meeting.date == ~N[2021-11-24 04:22:00]
      assert meeting.title == "some title"
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meetings.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture()
      update_attrs = %{date: ~N[2021-11-25 04:22:00], title: "some updated title"}

      assert {:ok, %Meeting{} = meeting} = Meetings.update_meeting(meeting, update_attrs)
      assert meeting.date == ~N[2021-11-25 04:22:00]
      assert meeting.title == "some updated title"
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
      assert {:error, %Ecto.Changeset{}} = Meetings.update_meeting(meeting, @invalid_attrs)
      assert meeting == Meetings.get_meeting!(meeting.id)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = Meetings.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> Meetings.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture()
      assert %Ecto.Changeset{} = Meetings.change_meeting(meeting)
    end
  end

  describe "events" do
    alias Rostrum.Meetings.Event

    import Rostrum.MeetingsFixtures

    @invalid_attrs %{hymn: nil, note: nil, order: nil, participants: nil, title: nil, type: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Meetings.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Meetings.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{hymn: 42, note: "some note", order: 42, participants: "some participants", title: "some title", type: :hymn}

      assert {:ok, %Event{} = event} = Meetings.create_event(valid_attrs)
      assert event.hymn == 42
      assert event.note == "some note"
      assert event.order == 42
      assert event.participants == "some participants"
      assert event.title == "some title"
      assert event.type == :hymn
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meetings.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{hymn: 43, note: "some updated note", order: 43, participants: "some updated participants", title: "some updated title", type: :musical_number}

      assert {:ok, %Event{} = event} = Meetings.update_event(event, update_attrs)
      assert event.hymn == 43
      assert event.note == "some updated note"
      assert event.order == 43
      assert event.participants == "some updated participants"
      assert event.title == "some updated title"
      assert event.type == :musical_number
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Meetings.update_event(event, @invalid_attrs)
      assert event == Meetings.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Meetings.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Meetings.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Meetings.change_event(event)
    end
  end
end
