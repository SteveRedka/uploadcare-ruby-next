module Uploadcare
  module Param
    # This header is added to track libraries using Uploadcare API
    class UserAgent
      # Generate header from Gem's config
      def self.call
        framework_data = Uploadcare.configuration.framework_data || 'UploadcareRuby'
        "UploadcareRuby/#{VERSION}/Pubkey_(Ruby/#{RUBY_VERSION}\;#{framework_data})"
      end
    end
  end
end
