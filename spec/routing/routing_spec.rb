# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it {
    is_expected.to route(:get, '/api/internet_protocols/1').to(
      format: :json,
      controller: 'api/internet_protocols',
      action: :show,
      id: 1
    )
  }
  it {
    is_expected.to route(:delete, '/api/internet_protocols/1').to(
      format: :json,
      controller: 'api/internet_protocols',
      action: :destroy,
      id: 1
    )
  }
end
