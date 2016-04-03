require 'rails_helper'

RSpec.describe SessionsController, :type => :request do
  describe 'logging in' do
    let(:authentication) { {:email => 'harry@harry.io', :password => 'secure password'} }
    let(:invalid_authentication) { {:userName => 'harry@harry.io', :password => 'invalid password'} }

    let!(:headers) { {'HTTP_ACCEPT' => 'application/json'} }
    let!(:harry) { User.create!(
        user_name: '양해리',
        password: 'secure password',
        department: '연구소',
        email: 'harry@harry.io',
        rank: '대리'
    )}
    context 'user provides valid authentication' do
      it 'respond with status ok' do
        post '/login', authentication, headers

        expect(response).to be_success
        jsonBody = JSON.parse(response.body)
        expect(jsonBody['userName']).to eq('양해리')
        expect(jsonBody['department']).to eq('연구소')
        expect(jsonBody['email']).to eq('harry@harry.io')
        expect(jsonBody['rank']).to eq('대리')
        expect(jsonBody).to_not contain_exactly('password')
      end
    end

    context 'user provides invalid authentication' do
      it 'respond with status not found' do
        post '/login', invalid_authentication

        expect(response).to be_not_found
      end
    end
  end
end