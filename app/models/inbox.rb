# == Schema Information
#
# Table name: inboxes
#
#  id              :integer          not null, primary key
#  unread_messages :integer
#  user_id         :integer
#
# Indexes
#
#  index_inboxes_on_user_id  (user_id)
#
class Inbox < ApplicationRecord

  belongs_to :user
  has_many :messages
 
end
