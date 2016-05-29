require 'rails_helper'

RSpec.describe UsersController, :type => :request do
  let!(:harry) { User.create!(:id => 11, :user_name => '양해리', :password => 'secure password',
                              :email => 'harry@harry.io', :rank => '대리',
                              :department => '연구소', :vacations_per_year => 15)}
  let!(:session_harry) { Session.create(:user => harry)}
  let!(:request_headers) { { 'HTTP_ACCEPT' => 'application/json', 'HTTP_AUTHORIZATION' => auth_string } }

  describe 'getting users' do
    context 'when user provides invalid authentication' do
      let!(:auth_string) { ActionController::HttpAuthentication::Token.encode_credentials('wrong token') }

      before do
        get '/users/11', nil, request_headers
      end

      it 'respond with unauthorized' do
        expect(response).to be_unauthorized
      end
    end


    context 'when user id exists' do
      let!(:auth_string) { ActionController::HttpAuthentication::Token.encode_credentials(session_harry.token) }

      before do
        get '/users/11', nil, request_headers
      end

      it 'respond with OK' do
        expect(response).to be_success
      end

      it 'respond with harry' do
        json = JSON.parse(response.body)

        expect(json).to include_json({id: 11, userName: '양해리',
                                      email: 'harry@harry.io', rank: '대리',
                                      department: '연구소', vacationsPerYear: 15})
        expect(json).not_to include_json({ password: 'secure password' })
      end
    end
  end
end