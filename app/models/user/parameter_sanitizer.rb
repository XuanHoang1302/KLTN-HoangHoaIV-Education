# frozen_string_literal: true

class User::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:username, :email])
    permit(:account_update, keys: %i[title given_name surname phone_number])
  end
end
