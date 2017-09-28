class SignUp
  include ActiveModel::Model
  attr_accessor :email_id, :name, :password, :confirm_password, :u_type
  validates_presence_of :email_id, :name, :password, :confirm_password, :u_type
  validates_with SignUpValidator
end