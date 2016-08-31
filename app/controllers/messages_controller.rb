class MessagesController < ApplicationController
  helper_method :current_or_guest_user

  def new
    @message = Message.new
  end

  def create
      @message = Message.new(message_params)
      if @message.valid?
        MessageMailer.message_me(@message).deliver_now
        redirect_to new_message_path
        flash[:success] = "Successfully Sent Custom Order, We Will Contact You Shortly"
      else
        flash[:error] = "Error In Sending Message"
        render :new
      end
    end

private

def message_params
  params.require(:message).permit(:name, :email, :subject, :content, :file)
end
end
