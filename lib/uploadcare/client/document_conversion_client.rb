# frozen_string_literal: true

module Uploadcare
  module Client
    # API client for document conversions
    # @see https://uploadcare.com/docs/document_conversion
    class DocumentConversionClient < ApiStruct::Client
      # convert group of files
      def convert(objects, format, store: false)
        actual_store = store ? 1 : 0
        uuids = objects_to_uuids(objects)
        params = { paths: uuids, store: actual_store }
        post("convert/document/#{Param::ConversionPath.call(format: format)}", params: params)
      end

      def api_root
        'https://ucarecdn.com'
      end

      def headers
        {
          'Content-type': 'application/json',
          'Accept': 'application/vnd.uploadcare-v0.5+json',
          'User-Agent': Uploadcare::Param::UserAgent.call
        }
      end

      def default_params
        {}
      end

      def default_path
        ''
      end

      def objects_to_uuids(objects)
        case objects.class
        when String
          [objects]
        when Uploadcare::Entity::File
          [objects.uuid]
        when Array
          uuids = objects.map { |obj| objects_to_uuids(obj) }.flatten
        end
      end
    end
  end
end
