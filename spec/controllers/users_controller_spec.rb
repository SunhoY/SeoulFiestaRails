require 'rails_helper'

RSpec.describe UsersController, :type => :request do
  describe 'getting users' do
    let!(:harry) { User.create!(:id => 11, :user_name => '양해리', :password => 'secure password',
                                :email => 'harry@harry.io', :rank => '대리',
                                :department => '연구소', :vacations_per_year => 15)}

    context 'when user id exists' do
      before do
        get '/users/11'
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