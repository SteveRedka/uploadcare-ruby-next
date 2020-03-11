# frozen_string_literal: true

# This object returns headers needed for authentication
# This authentication method is more secure, but more tedious
# https://uploadcare.com/docs/api_reference/rest/requests_auth/#auth-uploadcare

require 'digest/md5'

module Uploadcare
  module Param
    class AuthenticationHeader
      def self.call(**options)
        case Uploadcare.configuration.auth_type
        when 'Uploadcare'
          SecureAuthHeader.call(options)
        when 'Uploadcare.Simple'
          SimpleAuthHeader.call
        else
          raise ArgumentError, "Unknown auth_scheme: '#{Uploadcare.configuration.auth_type}'"
        end
      end
    end
  end
end