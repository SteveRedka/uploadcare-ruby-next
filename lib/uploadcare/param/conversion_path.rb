# frozen_string_literal: true

module Uploadcare
  module Param
    # This object generates conversion paths required by several API endpoints
    # @see https://uploadcare.com/docs/api_reference/cdn/
    # @see https://uploadcare.com/docs/video_encoding/
    # @see https://uploadcare.com/docs/document_conversion/
    class ConversionPath
      # generate conversion path of cdn url
      #
      # @example simple param
      #   str = ConversionPath.call(resize: '100x100')
      #   # '-/resize/100x100/'
      #
      # @example empty params should be defined with true
      #
      #  str = ConversionPath.call(flip:)
      #  # '-/flip/'
      def self.call(**params)
        path = ''
        params.each do |key, val|
          path = path + "-\/#{key}\/"
          path = path + "#{val}\/" if val && val != true
        end
        path
      end
    end
  end
end
