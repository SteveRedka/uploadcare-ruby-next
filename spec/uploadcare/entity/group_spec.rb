# frozen_string_literal: true

require 'spec_helper'

module Uploadcare
  RSpec.describe Group do
    subject { Group }
    it 'responds to expected methods' do
      %i[create info].each do |method|
        expect(subject).to respond_to(method)
      end
    end

    context 'info' do
      before do
        VCR.use_cassette('upload_group_info') do
          @group = subject.info('fc194fec-5793-4403-a593-686af4be412e~2')
        end
      end

      it 'represents a file group' do
        file_fields = %i[id datetime_created datetime_stored files_count cdn_url url files]
        file_fields.each do |method|
          expect(@group).to respond_to(method)
        end
      end

      it 'has files' do
        expect(@group.files).not_to be_empty
        expect(@group.files.first).to be_a_kind_of(Uploadcare::File)
      end
    end
  end
end
