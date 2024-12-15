# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'commit_msg_ai'
  s.version     = '0.0.1'
  s.executables << 'commit_msg_ai'
  s.summary     = 'Generate commit messages effortlessly using OpenAI.'
  s.description = 'CommitMsgAI is a CLI tool that leverages OpenAI to generate professional and concise commit messages following the Conventional Commits standard, streamlining your workflow.'
  s.authors     = ['Michiharu Ono']
  s.email       = 'michiharuono77@gmail.com'
  s.files       = ['lib/commit_msg_ai.rb', 'lib/commit_msg_ai/cli.rb']
  s.add_dependency 'ruby-openai', '~> 7.3'
  s.add_dependency 'faraday_middleware', '~> 1.2'
  s.add_development_dependency 'rspec', '~> 3.13'
  s.add_development_dependency 'rubocop', '~> 1.6'
  s.required_ruby_version = '>= 3.0'
  s.license = 'MIT'
end
