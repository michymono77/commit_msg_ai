# frozen_string_literal: true

require 'spec_helper'
require 'open3'
require 'commit_msg_ai/cli'

RSpec.describe CommitMsgAi::Cli, type: :class do
  describe '.run' do
    let(:api_token) do
      'test_token'
    end

    before do
      allow(Open3).to receive(:capture3).and_return(['diff output', '', double(success?: true)]) # Mock git diff
    end

    context 'when there are staged changes' do
      let(:target_commit_msg) { 'feat: add new feature' }

      it 'generates a commit message and commits the changes' do
        allow_any_instance_of(CommitMsgAi::Client).to receive(:generate_commit_message).and_return(target_commit_msg)
        allow(described_class).to receive(:ask_user_to_confirm_or_edit).and_return(target_commit_msg)
        allow(described_class).to receive(:split_commit_message).and_return([target_commit_msg, ''])

        expect { described_class.run }.to output(/Final Commit Message:/).to_stdout
      end
    end

    context 'when there are no staged changes' do
      before do
        allow(Open3).to receive(:capture3).and_return(['', 'No changes', double(success?: true)])
      end

      it 'notifies the user and exits' do
        expect { described_class.run }.to output("No staged changes to commit.\n").to_stdout
      end
    end

    context 'when API token is missing' do
      let(:api_token) { nil }

      it 'raises an error about the missing API token' do
        expect { described_class.run }.to output(/Error: Missing OpenAI API token/).to_stdout
      end
    end
  end
end
