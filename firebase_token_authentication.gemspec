# frozen_string_literal: true

require_relative "lib/firebase_token_authentication/version"

Gem::Specification.new do |spec|
  spec.name = "firebase_token_authentication"
  spec.version = FirebaseTokenAuthentication::VERSION
  spec.authors = ["Nick Fuller"]
  spec.email = ["nfuller52@gmail.com"]

  spec.summary = "Simple tool for verifying Firebase Authentication JWT tokens."
  spec.homepage = "https://github.com/alphabites/firebase_token_authentication"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alphabites/firebase_token_authentication"
  spec.metadata["changelog_uri"] = "https://github.com/alphabites/firebase_token_authentication/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) ||
        f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday-http-cache"
  spec.add_dependency "jwt"

  spec.add_development_dependency "debug"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
