Gem::Specification.new do |s|
  s.name        = 'chartd'
  s.version     = '0.0.1'
  s.summary     = 'Encode values for chartd.co'
  s.description = 'Chartd helps you encode values for use with chartd.co.'
  s.authors     = ['Max Lielje']
  s.email       = 'max@pagespeed.io'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test/*`.split("\n")

  s.homepage    = 'https://github.com/commissure/chartd-rb'
  s.license     = 'MIT'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'test-unit'
end
