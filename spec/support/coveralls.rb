# frozen_string_literal: true

WebMock.disable_net_connect!(allow: /coveralls\.io/) if defined?(Webmock)
