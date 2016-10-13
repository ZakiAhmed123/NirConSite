class MessagesController < ApplicationController
  helper_method :current_or_guest_user

  def new
    @message = Message.new

  end

  def create
      @message = Message.new(message_params)
      @message.subject = [@message.subject_1, @message.subject_2, @message.subject_3,@message.subject_4].reject(&:empty?).join(',')

      if @message.valid?
        MessageMailer.message_me(@message).deliver_now
        redirect_to new_message_path
        flash[:success] = "Successfully Sent Custom Order, We Will Contact You Shortly"
      else
        flash[:error] = "Error In Sending Message, Please Try Again"
        render :new
      end
    end

private

def message_params
  params.require(:message).permit(:name, :email, :subject, :content, :file == [],:subject_1, :subject_2, :subject_3, :subject_4)
end
end
