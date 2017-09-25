class LoginValidator < ActiveModel::Validator
  def validate(login)
    unless login.email_id.empty?
      unless User.exists?(login.email_id)
        login.errors.add(:user, login.email_id + ' does not exist')
      end
    end
  end
end