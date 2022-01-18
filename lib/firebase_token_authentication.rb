# frozen_string_literal: true

require_relative "firebase_token_authentication/access_token"
require_relative "firebase_token_authentication/google_x509_certificate"
require_relative "firebase_token_authentication/configuration"
require_relative "firebase_token_authentication/version"

module FirebaseTokenAuthentication
  class Error < StandardError; end

  class << self
    def verify_access_token(firebase_token)
      AccessToken.new(firebase_token).verify
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end
  end
end
