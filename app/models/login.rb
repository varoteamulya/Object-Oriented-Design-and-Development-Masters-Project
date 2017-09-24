class Login
  include ActiveModel::Model
  attr_accessor :email_id, :password
  validates_presence_of :email_id, :password
end