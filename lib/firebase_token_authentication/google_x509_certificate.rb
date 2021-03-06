# frozen_string_literal: true

require "faraday"
require "faraday-http-cache"
require "json"

module FirebaseTokenAuthentication
  class GoogleX509Certificate
    GOOGLE_CERT_URL = "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"

    def find(key_id)
      certificate = fetch_certificates[key_id]

      return OpenSSL::X509::Certificate.new(certificate) if certificate
    end

    def fetch_certificates
      client = Faraday.new do |builder|
        builder.use Faraday::HttpCache,
                    store: FirebaseTokenAuthentication.config.cache_store,
                    logger: FirebaseTokenAuthentication.config.logger

        builder.adapter Faraday.default_adapter
      end

      response = client.get(GOOGLE_CERT_URL, {}, { "Accept" => "application/json" })
      JSON.parse(response.body)
    end
  end
end
