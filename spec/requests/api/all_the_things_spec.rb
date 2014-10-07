require 'rails_helper'

RSpec.describe 'all the things', type: :request do

  describe 'auth' do

    context 'with permission' do
      let!(:user_1) { User.create! email: "l1@mycars.com", password: 'secret', level: 1, permission: true }

      it 'authenticates' do
        get '/cars', {}, { 'Authorization' => encode(user_1.email, user_1.password) }

        require 'pry'; binding.pry
      end

    end

    context 'w/o permission' do
      pending
      before do
        User.create! email: "l0@mycars.com", password: 'secret', level: 0, permission: false
      end

    end
  end
end
