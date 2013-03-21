# coding: utf-8
Gem::Specification.new do |s|
  s.name = 'rwenking'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.summary = "This is a Ruby Client for taobao.com's anti-phishing system wenking"
  s.authors = ["Fizz Wu"]
  s.email = "fizzwu@gmail.com"
  s.files = `git ls-files`.split("\n")
  
  s.add_dependency("rest-client", ">=1.6.0")
  s.add_dependency("nokogiri")
end