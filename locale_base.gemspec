require 'lib/locale_base/version'

spec = Gem::Specification.new do |s|
  
  s.name = 'locale_base'  
  s.author = 'John Crepezzi'
  s.add_development_dependency('rspec')
  s.add_dependency('easy_translate')
  s.description = 'locale_base is a way to easily translate yaml locale files from one language to another'
  s.email = 'john@crepezzi.com'
  s.files = Dir['lib/**/*.rb']
  s.has_rdoc = true
  s.homepage = 'http://github.com/seejohnrun/locale_base/'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'EasyTranslate backed YAML locale translation'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = LocaleBase::VERSION
  s.rubyforge_project = 'locale_base'

end