# frozen_string_literal: true

require "jwt"

module FirebaseTokenAuthentication
  class AccessToken
    attr_reader :certificate, :firebase_token, :key_id

    DECODE_OPTIONS = {
      algorithm: "RS256",
      verify_iat: true,
      verify_aud: true,
      verify_iss: true
    }.freeze

    def initialize(firebase_token, certificate = GoogleX509Certificate.new)
      @firebase_token = firebase_token
      @certificate = certificate
      @key_id = decode(key: nil, verify_key: false)[1]["kid"]
    end

    def verify
      decode(key: certificate.find(key_id))
    end

    private

    def decode(key: nil, verify_key: true)
      JWT.decode(firebase_token, key&.public_key, verify_key, decode_options)
    rescue StandardError => e
      raise FirebaseTokenAuthentication::Error, e.message
    end

    def decode_options
      config_opts = {
        aud: FirebaseTokenAuthentication.config.firebase_project_id,
        iss: "https://securetoken.google.com/#{FirebaseTokenAuthentication.config.firebase_project_id}"
      }

      DECODE_OPTIONS.merge(config_opts)
    end
  end
end
