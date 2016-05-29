require 'rails_helper'

RSpec.describe UsersController, :type => :request do
  let!(:harry) {
    User.create!(
        :email => 'harry@harry.io', :password => 'secure password',
        :user_name => '양해리'
    )
  }

  describe 'creating session' do
    context 'user provides non-existing email address' do
      it 'respond with not_found status code' do
        post '/login', {:email => 'not_exist@harry.io', :password => 'whatever'}

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user provides wrong password' do
      it 'respond with not_authenticated status code' do
        post '/login', {:email => 'harry@harry.io', :password => 'wrong password'}

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user provides valid password' do
      it 'respond with ok' do
        post '/login', {:email => 'harry@harry.io', :password => 'secure password'}

        expect(response).to have_http_status(:ok)
      end

      it 'respond with token' do
        post '/login', {:email => 'harry@harry.io', :password => 'secure password'}

        json = JSON.parse(response.body)

        expect(json['token'].length).to eq(128)
      end
    end
  end
end