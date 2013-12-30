Gem::Specification.new do |s|
  s.name        = "json-serializer"
  s.version     = "0.0.2"
  s.summary     = "Replaces hash-driven development with object-oriented development."
  s.description = s.summary
  s.authors     = ["Francesco Rodríguez"]
  s.email       = ["lrodriguezsanc@gmail.com"]
  s.homepage    = "https://github.com/frodsan/mocoso"
  s.license     = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest"
end
