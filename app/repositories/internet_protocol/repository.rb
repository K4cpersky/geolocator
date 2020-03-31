# frozen_string_literal: true

class InternetProtocol::Repository
  def self.create(params)
    InternetProtocol.create!(name: params[:name])
  end
end
