# frozen_string_literal: true

require 'spec_helper'

module Uploadcare
  module Client
    RSpec.describe DocumentConversionClient do
      subject { DocumentConversionClient.new }
        before do
        VCR.use_cassette('document') do
          @document = Uploadcare::Entity::File.info('e08e93a5-260d-4112-bc19-af74b548dd5f')
        end
      end

      it 'converts one file' do
        VCR.use_cassette('convert_document') do
          pending 'requires account with enabled conversion feature'
          response = subject.convert(@document.uuid, format: 'png')
          expect(response).not_to be_failure
        end
      end

      it 'converts multiple files'

      it 'handles store'
    end
  end
end
