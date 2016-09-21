class Message
    include ActiveModel::Model
    attr_accessor :name, :email, :subject, :content, :file, :subject_1, :subject_2, :subject_3, :subject_4
    validates :email, :subject, :content, presence: true
end
