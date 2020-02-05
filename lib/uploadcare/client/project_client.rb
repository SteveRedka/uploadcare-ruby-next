# frozen_string_literal: true

module Uploadcare
  # API client for getting project info
  # https://uploadcare.com/docs/api_reference/rest/handling_projects/
  class ProjectClient < RestClient
    rest_api 'projects'

    # https://uploadcare.com/api-refs/rest-api/v0.5.0/#tag/Project
    def show
      signed_get(uri: '/project/')
    end
  end
end
