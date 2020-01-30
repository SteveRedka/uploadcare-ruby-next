# frozen_string_literal: true

module Uploadcare
  # API client for handling single files
  # https://uploadcare.com/docs/api_reference/rest/accessing_files/
  # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/File
  class FileClient < RestClient
    # Gets list of files without pagination fields

    def index
      response = signed_request(method: 'GET', uri: '/files/')
      response.fmap { |i| i[:results] }
    end

    # Acquire file info
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/fileInfo

    def info(uuid)
      signed_request(method: 'GET', uri: "/files/#{uuid}/")
    end

    # 'copy' method is used to copy original files or their modified versions to default storage.
    # Source files MAY either be stored or just uploaded and MUST NOT be deleted.
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/copyFile

    def copy(**options)
      body = options.compact.to_json
      signed_request(method: 'POST', uri: "/files/", content: body)
    end

    # Copies file to current project
    # source can be UID or full CDN link
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/copyFile

    def local_copy(source, store: false)
      copy(source: source, store: store)
    end

    # copy file to different project
    # source can be UID or full CDN link
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/copyFile

    def remote_copy(source, target, make_public: false, pattern: '${default}')
      copy(source: source, target: target, make_public: make_public, pattern: pattern)
    end

    alias _delete delete

    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/deleteFile

    def delete(uuid)
      signed_request(method: 'DELETE', uri: "/files/#{uuid}/")
    end

    # Store a single file, preventing it from being deleted in 2 weeks
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/storeFile

    def store(uuid)
      signed_request(method: 'PUT', uri: "/files/#{uuid}/storage/")
    end
  end
end
