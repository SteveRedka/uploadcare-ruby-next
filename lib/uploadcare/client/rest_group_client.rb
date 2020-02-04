# frozen_string_literal true

module Uploadcare
  # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/Group/paths/~1groups~1%3Cuuid%3E~1storage~1/put
  class RestGroupClient < ApiStruct::Client
    rest_api

    # store all files in a group
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/Group/paths/~1groups~1%3Cuuid%3E~1storage~1/put

    def store(uuid)
      put(path: "groups/#{uuid}/storage/", headers: SimpleAuthenticationHeader.call)
    end

    # return paginated list of groups
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/groupsList

    def list(**options)
      get(path: "groups/", headers: SimpleAuthenticationHeader.call, params: options)
    end
  end
end
