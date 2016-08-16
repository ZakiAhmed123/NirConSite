class Message
    include ActiveModel::Model
    attr_accessor :name, :email, :subject, :content, :file
    validates :name, :email, :subject, :content, presence: true
end
