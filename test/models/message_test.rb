
require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "message has an unread status after creation" do
    assert_equal false, messages(:msg).read, "Message has unread status"
  end
  test "message is sent to the correct inbox and outbox" do
    assert_same 2, messages(:msg).inbox_id
    assert_same 0, messages(:msg).outbox_id
  end

end
