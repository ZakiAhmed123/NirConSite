class MessageMailer < ApplicationMailer

  default :to => "nirconrd@gmail.com"
  def message_me(msg)
    @msg=msg
    if @msg.file
      attachment_name = @msg.file.original_filename
      attachments[attachment_name] =  @msg.file.read
    else
  end
    mail from: @msg.email, subject: @msg.subject, body: "Message from #{msg.name} email:(#{msg.email}) is contacting Nirvana Construction in regards to -- #{msg.content}"
  end

end
