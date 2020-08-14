class MessagesController < ApplicationController
  before_action :set_inbox_payment, only: [:create]
 
  def show
    @message = Message.find(params[:id])
    @message.update_column(:read, TRUE)
    @inbox = Inbox.find(@message.inbox_id)
    @inbox.update_column(:unread_messages, @inbox.messages.where(read: FALSE).count)
  end

  def new
    @message = Message.new
    @original_msg = Message.find(params[:original_msg])
  end

  def create
    @message = Message.new(message_params)
    if @message.save
        @inbox = Inbox.find(@message.inbox_id)
        @inbox.update_column(:unread_messages, @inbox.messages.where(read: FALSE).count)
        redirect_to messages_path, notice: 'Message send.'
    else
         render :new 
    end
  end
  
  def call_api
    begin
      PaymentProviderFactory.provider.debit_card(User.current)
    rescue StandardError => e
      redirect_to messages_path, notice: 'Error happend.'
    end
  end

  private

    def set_inbox_payment
      if params[:message][:original_msg]
        @original_msg = Message.find(params[:message][:original_msg])    
        if (Time.now - @original_msg.created_at.to_time).to_i <= 8.days
          params[:message][:inbox_id] = User.default_doctor.inbox.id
        else
          params[:message][:inbox_id]= User.default_admin.inbox.id
        end
      elsif params[:message][:payment]
        Payment.create(user_id: User.current.id)
        call_api()
      end
    end

  
    def message_params
      params.require(:message).permit(:body, :outbox_id, :inbox_id, :read)
    end

end
