class MessageMailer < ApplicationMailer

  default :to => "nirconrd@gmail.com"
  def message_me(msg)
    @msg=msg
    if @msg.file.present?
    attachments['file'] =  {
      :content=>@msg.file.read,
      :mime_type=>@msg.file.content_type
    }
  else
  end
    mail from: @msg.email, subject: @msg.subject, body: @msg.content
  end

end
