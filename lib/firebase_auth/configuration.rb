# frozen_string_literal: true

module FirebaseAuth
  # Allow the application to configure the :firebase_project_id
  # to ensure the tokens are validated against the correct Firebase Project.
  class Configuration
    attr_accessor :firebase_project_id

    def initialize
      @firebase_project_id = nil
    end
  end
end
