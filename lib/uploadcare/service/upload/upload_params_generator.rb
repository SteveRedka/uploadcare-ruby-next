# frozen_string_literal: true

require 'digest'

module Uploadcare
  module Upload
    # This class generates body params for uploads
    # https://uploadcare.com/docs/api_reference/upload/request_based/
    class UploadParamsGenerator
      def self.call(store = 'auto')
        store = '1' if store == true
        store = '0' if store == false
        {
          'UPLOADCARE_PUB_KEY' => Uploadcare.configuration.public_key,
          'UPLOADCARE_STORE' => store,
          'signature' => (Upload::SignatureGenerator.call if Uploadcare.configuration.sign_uploads)
        }.reject{ |k, v| v.nil? }
      end
    end
  end
end
