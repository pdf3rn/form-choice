require_relative "lib/form_choice/version"

Gem::Specification.new do |spec|
  spec.name        = "form_choice"
  spec.version     = FormChoice::VERSION
  spec.authors     = ["Pedro Fernandez"]
  spec.email       = ["pdf015.pf@gmail.com"]
  spec.homepage    = "https://github.com/pdf3rn/form-choice"
  spec.summary     = "Choices.hs plugin for Rails 7."
  spec.description = "Display choices js in Rails application."
    spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pdf3rn/form-choice"
  spec.metadata["changelog_uri"] = "https://github.com/pdf3rn/form-choice/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4.2"
  spec.add_dependency "stimulus-rails", "~> 1.2.1"
  spec.add_dependency "activesupport", ">= 7.0.4.2"
  spec.add_runtime_dependency "actionview", ">= 7.0.4.2"
end
