# frozen_string_literal: true

require_relative "firebase_auth/configuration"
require_relative "firebase_auth/version"

# Entry point for the FirebaseAuth gem
module FirebaseAuth
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
