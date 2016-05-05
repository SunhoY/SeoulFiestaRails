require 'rails_helper'

RSpec.describe VacationsController, :type => :request do
  let!(:harry) {
    User.create!(:user_name => '양해리', :password => 'very secure',
                 :email => 'harry@harry.io', :rank => '대리', :department => '연구소',
                 :vacations_per_year => 15)
  }
  let!(:joan) {
    User.create!(:user_name => '조조앤', :password => 'not secure',
                 :email => 'joan@harry.io', :rank => '주임', :department => '관리부서',
                 :vacations_per_year => 17)
  }

  let!(:headers) { { :content_type => 'application/json' }}
  let!(:vacation_harry_1) {
    vacation = Vacation.create!(:user_id => harry.id, :vacation_status => 'requested',
                                :vacation_type => 'normal', :reason => '몸이 아픔')
    VacationItem.create!(:vacation_id => vacation.id, :vacation_date => Date.new(2016, 6, 29))
    VacationItem.create!(:vacation_id => vacation.id, :vacation_date => Date.new(2016, 6, 30))

    vacation
  }

  let!(:vacation_harry_2) {
    vacation = Vacation.create!(:user_id => harry.id, :vacation_status => 'rejected',
                                :vacation_type => 'family', :reason => '그냥 쉼')
    VacationItem.create!(:vacation_id => vacation.id, :vacation_date => Date.new(2016, 7, 4))
    VacationItem.create!(:vacation_id => vacation.id, :vacation_date => Date.new(2016, 7, 5))

    vacation
  }

  describe 'creating vacation' do
    let!(:vacation_json) {
      {
        :userId => harry.id, :type => 'normal',
        :startDate => '2016-06-19', :endDate => '2016-06-21',
        :reason => '몸이 아파서\n3일 쉽니다.'
      }
    }

    it 'creates vacation' do
      post '/vacations', vacation_json, headers

      expect(response).to be_success

      created = Vacation.where(:user_id => harry.id).last

      expect(created.user_id).to eq(harry.id)
      expect(created.vacation_type).to eq('normal')
      expect(created.vacation_status).to eq('requested')
      expect(created.reason).to eq('몸이 아파서\n3일 쉽니다.')
    end

    it 'creates vacation items' do
      post '/vacations', vacation_json, headers

      expect(response).to be_success

      created = Vacation.where(:user_id => harry.id).last
      vacation_items = created.vacation_items

      expect(vacation_items.size).to eq(3)
      expect(vacation_items.first.vacation_date.strftime('%Y-%m-%d')).to eq('2016-06-19')
      expect(vacation_items.second.vacation_date.strftime('%Y-%m-%d')).to eq('2016-06-20')
      expect(vacation_items.third.vacation_date.strftime('%Y-%m-%d')).to eq('2016-06-21')
    end
  end

  describe 'getting vacation' do
    context 'when user did not provide id' do
      it 'respond with all the vacation items belongs to user' do
        get "/vacations?userId=#{harry.id}"

        body = response.body
        json = JSON.parse body

        puts json.to_s
        expect(json.length).to eq(2)
        first = json[0]
        expect(first).to include_json({vacationStatus: 'requested', vacationType: 'normal',
                                       reason: '몸이 아픔'})
        expect(first).not_to include_json({userId: harry.id})
        first_vacation_items = first['vacationItems']
        expect(first_vacation_items.length).to eq(2)
        expect(first_vacation_items).to include_json([{vacationDate: '2016-06-29'}, {vacationDate: '2016-06-30'}])

        second = json[1]

        expect(second).not_to include_json({userId: harry.id})
        second_vacation_items = second['vacationItems']
        expect(second_vacation_items.length).to eq(2)
        expect(second_vacation_items).to include_json([{vacationDate: '2016-07-04'}, {vacationDate: '2016-07-05'}])
      end
    end
  end
end