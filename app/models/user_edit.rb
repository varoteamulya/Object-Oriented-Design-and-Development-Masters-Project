class UserEdit
  include ActiveModel::Model
  attr_accessor :email_id, :name, :password
  validates_presence_of :email_id, :name, :password
end