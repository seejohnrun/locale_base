require 'spec/rake/spectask'
require File.dirname(__FILE__) + '/lib/locale_base/version'
 
task :build do
  system "gem build locale_base.gemspec"
end

task :release => :build do
  # tag and push
  system "git tag v#{LocaleBase::VERSION}"
  system "git push origin --tags"
  # push the gem
  system "gem push locale_base-#{LocaleBase::VERSION}.gem"
end
