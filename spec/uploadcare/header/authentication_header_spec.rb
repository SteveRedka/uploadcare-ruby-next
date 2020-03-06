# frozen_string_literal: true

require 'spec_helper'

module Uploadcare
  RSpec.describe AuthenticationHeader do
    before do
      allow(SimpleAuthHeader).to receive(:call).and_return('SimpleAuth called')
      allow(SecureAuthHeader).to receive(:call).and_return('SecureAuth called')
    end

    it 'decides which header to use depending on configuration' do
      AUTH_TYPE = 'Uploadcare.Simple'
      expect(AuthenticationHeader.call).to eq('SimpleAuth called')
      AUTH_TYPE = 'Uploadcare'
      expect(AuthenticationHeader.call).to eq('SecureAuth called')
    end
  end
end
