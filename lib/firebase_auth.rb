# frozen_string_literal: true

require_relative "firebase_auth/access_token"
require_relative "firebase_auth/google_x509_certificate"
require_relative "firebase_auth/configuration"
require_relative "firebase_auth/version"

module FirebaseAuth
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
