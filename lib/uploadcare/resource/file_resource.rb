# frozen_string_literal: true

module Uploadcare
  module Resource
    # "Active Record"-style respresentation of File as object on Uploadcare server
    class FileResource
      attr_accessor :uuid, :response

      # FileResource can be initialized if you either know its uuid,
      # Or upload a new file with url or the file

      def initialize(**args)
        @file = args[:file] || args[:url]
        if @file
          upload
        else
          @uuid = args[:uuid]
          @response = args[:response]
        end
      end

      def info
        @response || Uploadcare::File.info(@uuid)
      end

      def store
        @response = Uploadcare::File.store(@uuid)
      end

      def is_stored?
        info.is_stored?
      end

      def delete
        @response = Uploadcare::File.delete(@uuid)
      end

      def is_deleted?
        info.datetime_removed != nil
      end

      def upload
        @response = Uploader.upload(@file)
        @uuid = @response.uuid
      end

      alias stored? is_stored?
      alias deleted? is_deleted?
    end
  end
end
