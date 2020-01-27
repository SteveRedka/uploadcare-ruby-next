require 'digest'

module Uploadcare
  # This class generates signatures for protected uploads
  # https://uploadcare.com/docs/api_reference/upload/signed_uploads/
  module Upload
    class SignatureGenerator
      def self.call
        expires_at = Time.now.to_i + 60 * 30
        to_sign = SECRET_KEY + expires_at.to_s
        signature = Digest::MD5.hexdigest(to_sign)
        {
          'signature': signature,
          'expire': expires_at
        }
      end
    end
  end
end
