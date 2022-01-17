# frozen_string_literal: true

RSpec.describe FirebaseAuth do
  it "has a version number" do
    expect(FirebaseAuth::VERSION).not_to be nil
  end

  describe "configuration" do
    let(:firebase_project_id) { "a-project-id" }

    before do
      FirebaseAuth.configure do |config|
        config.firebase_project_id = firebase_project_id
      end
    end

    it "sets the :firebase_project_id" do
      expect(FirebaseAuth.configuration.firebase_project_id).to eq firebase_project_id
    end
  end
end
