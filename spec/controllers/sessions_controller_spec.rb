require 'rails_helper'

RSpec.describe SessionsController, :type => :request do
  describe 'logging in' do
    let(:authentication) { {:user_name => 'harry', :password => 'secure password'} }
    let(:invalid_authentication) { {:user_name => 'harry', :password => 'invalid password'} }
    let!(:harry) { User.create!(user_name: 'harry', password: 'secure password') }

    context 'user provides valid authentication' do
      it 'respond with status ok' do
        post '/login', authentication

        expect(response).to be_success
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