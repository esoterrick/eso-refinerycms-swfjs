# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{refinerycms-swfjs}
  s.version           = %q{0.5.5}
  s.summary           = %q{Swfs extension for Refinery CMS}
  s.description       = %q{Manage swfs in RefineryCMS.}
  s.email             = %q{amishchuk@adexin.com}
  s.homepage          = %q{http://www.adexin.com}
  s.rubyforge_project = %q{refinerycms-swfjs}
  s.authors           = ['Anton Mishchuk']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency 'dragonfly'
  s.add_dependency 'rack-cache'
  s.add_dependency 'refinerycms-core'
end
