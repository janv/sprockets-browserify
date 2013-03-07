$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sprockets-browserify"
  s.version     = "0.0.1"
  s.authors     = ["Jan Varwig"]
  s.email       = ["jan@varwig.org"]
  s.homepage    = "http://jan.varwig.org"
  s.summary     = "Serve your node modules with Sprockets!"
  s.description = "Browserify packages node modules for the browser. This gem makes it easy to integrate this into the Rails asset pipeline or other Sprockets chains."

  s.files = Dir["{lib,node_modules}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc", "package.json"]
  #s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "sprockets",     "~> 2.1"
end
