# frozen_string_literal: true

require 'spec_helper'

module Uploadcare
  RSpec.describe ProjectClient do
    before do
      stub_const('Uploadcare::PUBLIC_KEY', 'foo')
    end

    it 'requests info about target project' do
      VCR.use_cassette('project') do
        response = ProjectClient.new.show
        expect(response.value![:pub_key]).to eq(PUBLIC_KEY)
      end
    end
  end
end
