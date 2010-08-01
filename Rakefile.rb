require 'lib/freelancer'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'generate API documentation to doc/rdocs/index.html'

spec=Gem::Specification.new do |s|
  s.name = 'freelancer4r'
  s.version = Freelancer::VERSION

  s.platform = Gem::Platform::RUBY
  s.summary = 'Freelancer API for ruby'
  s.description = 'Freelancer API for ruby. More informaito about freelancer api see http://developer.freelancer.com'

  s.require_paths = ['lib']

  s.files  = ['README.rdoc', 'Rakefile.rb', 'LICENSE.txt']
  s.files += ['lib/freelancer.rb'] + Dir['lib/freelancer/**/*.rb']

  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.rdoc', '--inline-source']
  s.extra_rdoc_files = ['README.rdoc','CHANGELOG']

  s.authors = ['Janos Haber']
  s.email = 'freelancer4r@googlegroups.com'
  s.homepage = 'http://github.com/b0c1/freelancer4r'

  s.add_dependency(%q<json>, [">= 1.4.0"])
  s.add_dependency(%q<oauth>, [">= 0.4.1"])
end

Rake::RDocTask.new do |rd|
  rd.rdoc_dir = ENV['RDOC_DIR'] if ENV['RDOC_DIR']
  rd.title = "Freelancer.com API for ruby documentation"
  rd.main = 'README.txt'
  rd.rdoc_files.include 'README.rdoc', 'CHANGELOG', "lib/freelancer.rb", "lib/freelancer/**/*\.rb"

  rd.options << '--inline-source'
  rd.options << '--line-numbers'
  rd.options << '--all'
  #  rd.options << '--fileboxes'
  #  rd.options << '--diagram'
end


Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end 