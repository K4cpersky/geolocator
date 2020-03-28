# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :internet_protocols, only: [:show]
  end
end
