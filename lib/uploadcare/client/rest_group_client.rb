# frozen_string_literal true

module Uploadcare
  # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/Group/paths/~1groups~1%3Cuuid%3E~1storage~1/put
  class RestGroupClient < RestClient
    # store all files in a group
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/Group/paths/~1groups~1%3Cuuid%3E~1storage~1/put

    def store(uuid)
      put(uri: "/groups/#{uuid}/storage/")
    end

    # return paginated list of groups
    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#operation/groupsList

    def list(**options)
      query = ''
      query = '?' + options.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join('&') unless options.empty?
      get(uri: "/groups/#{query}")
    end
  end
end
