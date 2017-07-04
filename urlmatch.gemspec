lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.author      = 'Henry heath'
  s.email       = 'henry.heath@onfido.com'
  s.name        = 'urlmatch'
  s.version     = '0.1.0'
  s.summary     = "fnmatch for the web"
  s.description = "Verify URLs confirm to expected patterns. Ruby port of Jesse Pollak's Urlmatch"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]

  s.license     = 'MIT'
  s.homepage    = 'https://rubygems.org/gems/example'

  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"

  # This is due to Ruby 2.0 keyword arguments.
  s.required_ruby_version = '>= 2.0'
end
