Gem::Specification.new do |s|
  s.name        = "json-serializer"
  s.version     = "0.0.4"
  s.summary     = "Customize JSON ouput through serializer objects."
  s.description = s.summary
  s.authors     = ["Francesco Rodríguez"]
  s.email       = ["frodsan@me.com"]
  s.homepage    = "https://github.com/frodsan/json-serializer"
  s.license     = "Unlicense"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest"
end
