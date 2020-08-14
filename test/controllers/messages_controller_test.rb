require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
    test "unread messages is decremented when a doctor reads one" do
        unread_first = inboxes(:doctor).unread_messages
        get message_path(messages(:msg).id)
        assert_same (unread_first - 1) , Inbox.find(inboxes(:doctor)).unread_messages
    end
    test "unread messages is incremented when a doctor reads one" do
        unread_first = inboxes(:doctor).unread_messages
        post messages_path, message: {body: "Hello World", inbox_id: inboxes(:doctor).id, outbox_id: 1, read: FALSE}
        assert_same (unread_first + 1) , Inbox.find(inboxes(:doctor)).unread_messages
    end

end