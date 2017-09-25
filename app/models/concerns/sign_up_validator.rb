class SignUpValidator < ActiveModel::Validator
  def validate(sign_up)
    puts 'validating sign up', sign_up
    unless sign_up.password == sign_up.confirm_password
      sign_up.errors.add(:password, 'does not match with confirm password')
    end

    unless sign_up.email_id.empty?
      if User.exists?(sign_up.email_id)
        sign_up.errors.add(:user, sign_up.email_id + ' already exists')
      end
    end
  end
end