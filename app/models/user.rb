class User < ApplicationRecord

  validates :email_id, :presence => true, :uniqueness => true
  validates :password, :presence => true

  self.primary_key = 'email_id'

end
