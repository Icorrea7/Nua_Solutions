class AddUnreadMessagesToInboxes < ActiveRecord::Migration[5.0]
  def change
    add_column :inboxes, :unread_messages, :integer
  end
end
