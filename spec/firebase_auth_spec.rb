# frozen_string_literal: true

RSpec.describe FirebaseAuth do
  it "has a version number" do
    expect(FirebaseAuth::VERSION).not_to be nil
  end

  describe "configuration" do
    let(:firebase_project_id) { "a-project-id" }
    let(:cache_store) { double }

    before do
      FirebaseAuth.configure do |config|
        config.firebase_project_id = firebase_project_id
        config.cache_store = cache_store
      end
    end

    it "sets the :firebase_project_id" do
      expect(FirebaseAuth.config.firebase_project_id).to eq firebase_project_id
    end

    it "sets the :cache_store" do
      expect(FirebaseAuth.config.cache_store).to eq cache_store
    end
  end
end
