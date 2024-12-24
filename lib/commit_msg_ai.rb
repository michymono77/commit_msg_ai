# frozen_string_literal: true

require 'openai'
require_relative 'commit_msg_ai/version'

module CommitMsgAi
  class Client
    def initialize(api_token)
      @client = OpenAI::Client.new(
        access_token: api_token,
        log_errors: true
      )
    end

    def generate_commit_message(diff)
      prompt = generate_prompt(diff)
      response = @client.chat(
        parameters: {
          model: 'gpt-3.5-turbo-0125',
          messages: [
            { role: 'system', content: 'You are an assistant generating Git commit messages.' },
            { role: 'user', content: prompt }
          ]
        }
      )
      response.dig('choices', 0, 'message', 'content') || 'Error: Unable to generate commit message.'
    rescue StandardError => e
      "Error communicating with OpenAI API: #{e.message}"
    end

    private

    def generate_prompt(diff)
      <<~PROMPT
        Act as a professional Ruby on Rails developer who follows "Conventional Commits", please answer the questions.
        In case you do not know, "Conventional Commits" is as follows:
        Summary starts here:
        The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention dovetails with SemVer, by describing the features, fixes, and breaking changes made in commit messages.
        The commit message should be structured as follows:

        <type>[optional scope]: <description>

        [optional body]

        [optional footer(s)]
        The commit contains the following structural elements, to communicate intent to the consumers of your library:

        fix: a commit of the type fix patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
        feat: a commit of the type feat introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
        BREAKING CHANGE: a commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
        types other than fix: and feat: are allowed, for example @commitlint/config-conventional (based on the Angular convention) recommends build:, chore:, ci:, docs:, style:, refactor:, perf:, test:, and others.
        footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
        Additional types are not mandated by the Conventional Commits specification, and have no implicit effect in Semantic Versioning (unless they include a BREAKING CHANGE). A scope may be provided to a commit’s type, to provide additional contextual information and is contained within parenthesis, e.g., feat(parser): add ability to parse arrays.

        Examples
        Commit message with description and breaking change footer
        feat: allow provided config object to extend other configs

        BREAKING CHANGE: `extends` key in config file is now used for extending other config files
        Commit message with ! to draw attention to breaking change
        feat!: send an email to the customer when a product is shipped
        Commit message with scope and ! to draw attention to breaking change
        feat(api)!: send an email to the customer when a product is shipped
        Commit message with both ! and BREAKING CHANGE footer
        chore!: drop support for Node 6

        BREAKING CHANGE: use JavaScript features not available in Node 6.
        Commit message with no body
        docs: correct spelling of CHANGELOG
        Commit message with scope
        feat(lang): add Polish language

        Summary ends here.

        Now, create a concise, professional Git commit message using the "Conventonal Commit" without body and footer based on the following Git diff:
        #{diff}
      PROMPT
    end
  end
end
