require 'jwt'

module AuthToken
  def issue_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def valid_token?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end
