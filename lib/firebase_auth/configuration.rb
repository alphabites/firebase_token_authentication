# frozen_string_literal: true

module FirebaseAuth
  class Configuration
    attr_accessor :cache_store, :firebase_project_id

    def initialize
      @cache_store = nil
      @firebase_project_id = nil
    end
  end
end
