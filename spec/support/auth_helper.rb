def encode(email, password)
  ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
end
