# frozen_string_literal: true

module Uploadcare
  module Param
    # This object returns simple header for authentication
    # Simple header is relatively unsafe, but can be useful for debug and development
    # @see https://uploadcare.com/docs/api_reference/rest/requests_auth/#auth-simple
    class SimpleAuthHeader
      def self.call
        public_key = Uploadcare.configuration.public_key
        secret_key = Uploadcare.configuration.secret_key
        { 'Authorization': "Uploadcare.Simple #{public_key}:#{secret_key}" }
      end
    end
  end
end
