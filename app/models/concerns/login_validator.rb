class LoginValidator < ActiveModel::Validator
  def validate(login)
    unless login.email_id.empty?
      unless User.exists?(email_id: login.email_id, password: login.password)
        login.errors.add(:user, login.email_id + ' and password combination does not exist')
      end
    end
  end
end