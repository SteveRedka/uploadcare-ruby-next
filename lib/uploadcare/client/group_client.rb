# frozen_string_literal true

module Uploadcare
  # Groups serve a purpose of better organizing files in your Uploadcare projects.
  # You can create one from a set of files by using their UUIDs.
  # https://uploadcare.com/docs/api_reference/upload/groups/
  class GroupClient < ApiStruct::Client
    upload_api

    # Create files group from a set of files by using their UUIDs.
    # https://uploadcare.com/api-refs/upload-api/#operation/createFilesGroup

    def create(file_ids, **options)
      body_hash = {
        pub_key: PUBLIC_KEY,
      }.merge(file_params(file_ids), options)
      body = HTTP::FormData::Multipart.new(body_hash)
      post(path: 'group/',
           headers: { 'Content-type': body.content_type },
           body: body)
    end

    # Get group info
    # https://uploadcare.com/api-refs/upload-api/#operation/filesGroupInfo

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
