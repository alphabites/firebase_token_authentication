# frozen_string_literal: true

require_relative "firebase_authentication/access_token"
require_relative "firebase_authentication/google_x509_certificate"
require_relative "firebase_authentication/configuration"
require_relative "firebase_authentication/version"

module FirebaseAuthentication
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
