class MessagesController < ApplicationController
  before_action :set_inbox, only: [:create]
  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @original_msg = Message.find(params[:original_msg])
  end

  def create
    @message = Message.new(message_params)
    @inbox = Inbox.find(@message.inbox_id)
    @inbox.update_column(:unread_messages, @inbox.messages.where(read: FALSE).count)
    if @message.save
        redirect_to @message, notice: 'Message send.'
    else
         render :new 
    end
  end

  private
    def set_inbox
      @original_msg = Message.find(params[:message][:original_msg])
      if (Time.now - @original_msg.created_at.to_time).to_i <= 8.days
        params[:message][:inbox_id] = User.default_doctor.inbox.id
      else
        params[:message][:inbox_id]= User.default_admin.inbox.id
      end
    end
    def message_params
      params.require(:message).permit(:body, :outbox_id, :inbox_id, :read)
    end

end
