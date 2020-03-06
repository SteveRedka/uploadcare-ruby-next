# frozen_string_literal: true

require 'spec_helper'

module Uploadcare
  RSpec.describe MultipartUploadClient do
    subject { MultipartUploadClient.new }
    let!(:small_file) { ::File.open('spec/fixtures/kitten.jpeg') }
    # Replace this file with actual big file when rewriting fixtures
    let!(:big_file) { ::File.open('spec/fixtures/big.jpeg') }

    describe 'upload_start' do
      context 'small file' do
        it 'doesnt upload small files' do
          VCR.use_cassette('upload_multipart_upload_start_small') do
            response = subject.upload_start(small_file)
            expect(response.to_s).to include('File size can not be less than 10485760 bytes')
          end
        end
      end

      context 'large file' do
        it 'returns links for upload' do
          allow_any_instance_of(HTTP::FormData::File).to receive(:size).and_return(100 * 1024 * 1024)
          VCR.use_cassette('upload_multipart_upload_start_large') do
            response = subject.upload_start(small_file)
            expect(response.success[:parts].count).to eq 20
          end
        end
      end
    end

    describe 'upload_complete' do
      context 'unfinished' do
        it 'informs about unfinished upload' do
          VCR.use_cassette('upload_multipart_upload_complete_unfinished') do
            response = subject.upload_complete('7d9f495a-2834-4a2a-a2b3-07dbaf80ac79')
            expect(response.to_s).to include('File size mismatch. Not all parts uploaded?')
          end
        end
      end

      context 'wrong uid' do
        it 'informs that file is not found' do
          VCR.use_cassette('upload_multipart_upload_complete_wrong_id') do
            response = subject.upload_complete('nonexistent')
            expect(response.to_s).to include('File is not found')
          end
        end
      end

      context 'already uploaded' do
        it 'returns file data' do
          VCR.use_cassette('upload_multipart_upload_complete') do
            response = subject.upload_complete('d8c914e3-3aef-4976-b0b6-855a9638da2d')
            expect(response.to_s).to include('File is already uploaded')
          end
        end
      end
    end

    describe 'upload' do
      it 'does the entire multipart upload routine' do
        VCR.use_cassette('upload_multipart_upload') do
          response = subject.upload(big_file)
          response_value = response.value!
          expect(response_value[:uuid]).not_to be_empty
        end
      end

      it 'returns server answer if file is too small' do
        VCR.use_cassette('upload_multipart_upload_small') do
          response = subject.upload(small_file)
          expect(response.to_s).to include('File size can not be less than 10485760 bytes')
        end
      end
    end
  end
end
