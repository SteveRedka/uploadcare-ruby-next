# frozen_string_literal: true

require 'spec_helper'

module Uploadcare
  module Resource
    RSpec.describe FileResource do
      subject { FileResource }
      let(:file_uuid) { '730c5fb9-bbe7-402c-9c26-789e92a5a353' }
      let(:file) { subject.new(uuid: file_uuid) }

      describe 'initialize' do
        it 'initializes existing files from uuid' do
          FileResource.new(uuid: file_uuid)
        end

        it 'uploads' do
          VCR.use_cassette('resource_uploads') do
            resource = FileResource.new(file: ::File.open('spec/fixtures/kitten.jpeg'))
            expect(resource.response.image_info).not_to be_empty
            expect(resource.uuid).to be_a_kind_of(String)
          end
        end
      end

      describe 'is_stored?' do
        it 'is boolean' do
          VCR.use_cassette('resource_is_stored') do
            expect(file.is_stored?).to be_boolean
          end
        end
      end

      describe 'is_deleted?' do
        it 'is boolean' do
          VCR.use_cassette('resource_is_stored') do
            expect(file.is_deleted?).to be_boolean
          end
        end
      end

      describe 'delete' do
        it 'works' do
          VCR.use_cassette('rest_file_delete') do
            uuid = 'e9a9f291-cc52-4388-bf65-9feec1c75ff9'
            resource = subject.new(uuid: uuid)
            resource.delete
            expect(resource.is_deleted?).to eq true
          end
        end
      end
    end
  end
end
