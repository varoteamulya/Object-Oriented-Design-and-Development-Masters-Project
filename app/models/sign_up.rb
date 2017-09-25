class SignUp
  include ActiveModel::Model
  attr_accessor :email_id, :name, :password, :confirm_password
  validates_presence_of :email_id, :name, :password, :confirm_password
  validates_with SignUpValidator
end