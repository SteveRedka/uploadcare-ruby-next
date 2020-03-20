# frozen_string_literal: true

require 'spec_helper'
require 'param/conversion_path'

module Uploadcare
  RSpec.describe Param::ConversionPath do
    subject { Param::ConversionPath }

    it 'generates conversion paths' do
      path = subject.call(dimensions: '100x100', format: 'png', flip: true)
      expect(path).to eq('-/dimensions/100x100/-/format/png/-/flip/')
    end
  end
end
