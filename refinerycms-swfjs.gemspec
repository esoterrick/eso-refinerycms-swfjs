# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-swfjs'
  s.version           = '0.0.1'
  s.summary           = 'Swfs extension for Refinery CMS'
  s.description       = 'Manage swfs in RefineryCMS.'
  s.email             = 'esosoundz@gmail.com'
  s.homepage          = 'http://github.com/esoterrick/eso-refinerycms-swfjs'
  s.rubyforge_project = 'refinerycms-swfjs'
  s.authors           = 'Terrick Ramsey'
  s.license           = 'MIT'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency 'dragonfly'
  s.add_dependency 'rack-cache'
  s.add_dependency 'refinerycms-core'
end
