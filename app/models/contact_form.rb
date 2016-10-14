class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :file,      :attachment => true
  attribute :content    :validate => true
  attribute :subject_1
  attribute :subject_2
  attribute :subject_3
  attribute :subject_4
  attribute :subject

def headers
  {
    :subject => "#{subject}",
    :to => "nirconrd@gmail.com",
    :from => %("#{name}" <#{email}>)
  }
end

end
