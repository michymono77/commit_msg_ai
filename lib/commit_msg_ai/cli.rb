# frozen_string_literal: true

require 'open3'
require 'shellwords'
require 'commit_msg_ai'

module CommitMsgAi
  # ================================================================================
  # The `CommitMsgAi::Cli` class provides a command-line interface for generating
  # commit messages using the Commit Message AI service. It fetches the staged git
  # diff, communicates with the AI service to generate a commit message, and allows
  # the user to confirm or edit the message before committing the changes.
  # ================================================================================
  class Cli
    def self.run
      api_token = ENV.fetch('OPENAI_ACCESS_TOKEN', nil)

      unless api_token
        puts 'Error: Missing OpenAI API token. Please set OPENAI_ACCESS_TOKEN in your environment variables.'
        exit 1
      end

      diff = git_diff
      if diff.empty?
        puts 'No staged changes to commit.'
        exit 0
      end

      commit_ai = CommitMsgAi::Client.new(api_token)
      commit_message = commit_ai.generate_commit_message(diff)

      final_message = ask_user_to_confirm_or_edit(commit_message)
      subject, body = split_commit_message(final_message)

      puts "\nFinal Commit Message:\n\n#{final_message}"
      puts "\nRunning git commit..."
      system("git commit -m #{Shellwords.escape(subject)} -m #{Shellwords.escape(body)}")
    end

    def self.git_diff
      stdout, stderr, status = Open3.capture3('git diff --staged')
      raise "Error getting git diff: #{stderr}" unless status.success?

      stdout.strip
    rescue StandardError => e
      puts e.message
      exit 1
    end

    def self.ask_user_to_confirm_or_edit(commit_message)
      puts "\nSuggested Commit Message:\n\n#{commit_message}"
      loop do
        puts "\nDo you want to:"
        puts '1. Use this message as-is.'
        puts '2. Edit this message.'
        puts '3. Abort the commit process.'
        print "\nEnter your choice (1, 2, or 3): "

        case gets.strip
        when '1'
          return commit_message
        when '2'
          puts "\nEnter your custom commit message (leave blank to keep the original):"
          puts commit_message
          print '> '
          edited_message = $stdin.read.strip
          return edited_message.empty? ? commit_message : edited_message
        when '3'
          puts "\nCommit process aborted."
          exit 0
        else
          puts "\nInvalid choice. Please try again."
        end
      end
    end

    def self.split_commit_message(message)
      lines = message.strip.split("\n", 2)
      subject = lines[0]
      body = lines[1..]&.join("\n") || ''
      [subject, body]
    end
  end
end
