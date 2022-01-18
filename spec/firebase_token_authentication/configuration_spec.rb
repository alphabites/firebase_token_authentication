# frozen_string_literal: true

RSpec.describe FirebaseTokenAuthentication::Configuration do
  subject(:config) { described_class.new }

  it "instantiates the :firebase_project_id as nil" do
    expect(config.firebase_project_id).to be_nil
  end

  it "instantiates the :cache_store as nil" do
    expect(config.cache_store).to be_nil
  end

  it "responds to :firebase_project_id" do
    expect(config.respond_to?(:firebase_project_id)).to be_truthy
  end

  it "responds to :firebase_project_id" do
    expect(config.respond_to?(:cache_store)).to be_truthy
  end

  it "sets :firebase_project_id" do
    new_val = "token-123213"

    config.firebase_project_id = new_val

    expect(config.firebase_project_id).to eq(new_val)
  end

  it "sets :cache_store" do
    cache_store = double

    config.cache_store = cache_store

    expect(config.cache_store).to eq(cache_store)
  end
end
