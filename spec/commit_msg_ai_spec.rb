# frozen_string_literal: true

require 'spec_helper'
require 'commit_msg_ai'

RSpec.describe CommitMsgAi, type: :class do
  let(:api_token) { 'test_token' }
  let(:commit_msg_ai) { described_class.new(api_token) }

  describe '#generate_commit_message' do
    let(:diff) do
      "diff --git a/file.rb b/file.rb\nindex 12345..67890 100644\n--- a/file.rb\n+++ b/file.rb\n@@ -1,3 +1,3 @@\n-Old code\n+New code"
    end

    context 'when OpenAI API returns a valid response' do
      let(:api_response) do
        { 'choices' => [{ 'message' => { 'content' => 'feat: add new feature' } }] }
      end

      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return(api_response)
      end

      it 'returns the generated commit message' do
        message = commit_msg_ai.generate_commit_message(diff)
        expect(message).to eq('feat: add new feature')
      end
    end

    context 'when OpenAI API returns an error' do
      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_raise(StandardError, 'API Error')
      end

      it 'returns an error message' do
        message = commit_msg_ai.generate_commit_message(diff)
        expect(message).to eq('Error communicating with OpenAI API: API Error')
      end
    end
  end
end
