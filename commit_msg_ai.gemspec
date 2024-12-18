# frozen_string_literal: true

require_relative 'lib/commit_msg_ai/version'

Gem::Specification.new do |s|
  s.name        = 'commit_msg_ai'
  s.version     = CommitMsgAi::VERSION
  s.executables << 'commit_msg_ai'
  s.summary     = 'Generate commit messages effortlessly using OpenAI.'
  s.description = 'CLI tool that leverages OpenAI to generate commit messages following the Conventional Commits standard.'
  s.authors     = ['Michiharu Ono']
  s.email       = 'michiharuono77@gmail.com'
  s.files       = Dir.glob('lib/**/*.rb')
  s.add_dependency 'faraday_middleware', '~> 1.2'
  s.add_dependency 'ruby-openai', '~> 7.3'
  s.required_ruby_version = '>= 3.0'
  s.license = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'
end
