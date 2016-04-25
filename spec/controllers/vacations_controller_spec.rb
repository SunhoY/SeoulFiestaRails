require 'rails_helper'

RSpec.describe VacationsController, :type => :request do
  describe 'creating vacation' do
    let!(:vacation) {
      {
        :userId => 21, :type => 'normal',
        :startDate => '2016-06-19', :endDate => '2016-06-21',
        :reason => '몸이 아파서\n3일 쉽니다.'
      }
    }
    let!(:headers) { { :content_type => 'application/json' }}

    it 'creates vacation' do
      post '/vacations', vacation, headers

      expect(response).to be_success

      created = Vacation.where(:user_id => 21).first

      expect(created.user_id).to eq(21)
      expect(created.vacation_type).to eq('normal')
      expect(created.start_date.strftime('%Y-%m-%d')).to eq('2016-06-19')
      expect(created.end_date.strftime('%Y-%m-%d')).to eq('2016-06-21')
      expect(created.reason).to eq('몸이 아파서\n3일 쉽니다.')
    end
  end
end