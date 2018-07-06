require 'rails_helper'

RSpec.describe 'Widgets', type: :request do
  describe 'GET /widgets' do
    it 'returns success' do
      get widgets_path
      expect(response).to have_http_status(200)
    end
  end
end
