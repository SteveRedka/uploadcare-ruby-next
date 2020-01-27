# frozen_string_literal true

module Uploadcare
  class GroupClient < ApiStruct::Client
    upload_api

    # https://uploadcare.com/api-refs/upload-api/#operation/createFilesGroup

    def create(file_ids, **options)
      body_hash = {
        pub_key: PUBLIC_KEY,
      }.merge(file_params(file_ids), options)
      body = HTTP::FormData::Multipart.new(body_hash)
      response = post(path: 'group/',
           headers: { 'Content-type': body.content_type },
           body: body)
    end

    def info(group_id)
      get(path: 'group/info/', params: { 'pub_key': PUBLIC_KEY, 'group_id': group_id })
    end

    private

    def file_params(file_ids)
      ids = (0...file_ids.size).map { |i| "files[#{i}]" }
      ids.zip(file_ids).to_h
    end
  end
end
