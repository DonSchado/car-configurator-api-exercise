require 'rails_helper'

RSpec.describe 'all the things', type: :request do

  describe 'auth' do
    before { get '/cars', {}, { 'Authorization' => encode(user.email, user.password) } }

    context 'with permission' do
      let!(:user) { FactoryGirl.create(:user, permission: true) }

      it 'authenticates' do
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'w/o permission' do
      let!(:user) { FactoryGirl.create(:user, permission: false) }

      it "says go away!" do
        expect(response.status).to eq(401)
      end
    end
  end


  describe 'cars endpoint' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:car_1) { Car.create!(levels: [3]   , description: "Audi A3 Sportback S line 1.8 TFSI 6 speed", price_cents: 3400000) }
    let!(:car_2) { Car.create!(levels: [2,3] , description: "Audi A4 Avant Black Edition 2.0 TDI multitronic ", price_cents: 3200000) }

    describe '#index' do
      it 'returns all the amazing cars' do
        get '/cars', {}, { 'Authorization' => encode(user.email, user.password) }
        expect(json(response.body)).to match_array([car_1.as_json, car_2.as_json])
      end
    end
  end


  describe 'car_config' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:car_1) { Car.create!(levels: [3]   , description: "Audi A3 Sportback S line 1.8 TFSI 6 speed", price_cents: 3400000) }

    describe '#create' do

      context 'valid' do
        let(:car_config) do
          {
            car_id: car_1.id,
            leasing_period: 24,
            leasing_km: 20_000,
            package: 'p1',
          }
        end

        it 'create some config for you', :vcr do
          post '/car_configs', { car_config: car_config } , { 'Authorization' => encode(user.email, user.password) }
          expect(response.status).to eq(201)
          expect(json(response.body)[:leasing_rate]).to eq("€708.00")
        end
      end

      context 'invalid (external API)' do
        let(:car_config) do
          {
            car_id: car_1.id,
            leasing_period: 240,
            leasing_km: 999999999,
            package: 'p2',
          }
        end

        it 'is unprocessable', :vcr do
          post '/car_configs', { car_config: car_config } , { 'Authorization' => encode(user.email, user.password) }
          expect(response.status).to eq(422)
          expect(json(response.body)).to eq(:base => ["Illegal number of kilometers (2112)", "Illegal period (2132)"])
        end
      end

      context 'invalid because of validations' do
        let!(:user) { User.create! email: "l3@mycars.com", password: 'secret', level: 3, permission: true }
        let!(:car_2) { Car.create!(levels: [2,3] , description: "Audi A4 Avant Black Edition 2.0 TDI multitronic ", price_cents: 3200000) }

        describe 'users leasing_rate_limit' do
          let(:car_config) do
            {
              car_id: car_2.id,
              leasing_period: 24,
              leasing_km: 20_000,
              package: 'p1',
            }
          end

          it 'exceeds the the limit', :vcr do
            post '/car_configs', { car_config: car_config } , { 'Authorization' => encode(user.email, user.password) }
            expect(response.status).to eq(422)
            expect(json(response.body)).to eq(leasing_limit: ['over limit'])
          end
        end

        describe 'users package level' do
          let(:car_config) do
            {
              car_id: car_2.id,
              leasing_period: 48,
              leasing_km: 10_000,
              package: 'p2',
            }
          end

          it 'is not allowed package', :vcr do
            post '/car_configs', { car_config: car_config } , { 'Authorization' => encode(user.email, user.password) }
            expect(response.status).to eq(422)
            expect(json(response.body)).to eq(package_error: ['p2 not allowed'])
          end
        end

      end
    end
  end

  describe 'order the car_config' do
    let(:user) { FactoryGirl.create(:user) }
    let(:car) { Car.create!(levels: [2,3] , description: "Audi A4 Avant Black Edition 2.0 TDI multitronic ", price_cents: 3200000) }
    let(:car_config) { CarConfig.create!(car_id: car.id, leasing_period: 24, leasing_km: 100000, package: 'p1', leasing_rate_cents: 1000) }
    let(:order) do
      {
        address: 'somewhere',
        car_house: 'foo',
      }
    end

    it 'has status created' do
      post "/car_configs/#{car_config.id}/order", { order: order }, { 'Authorization' => encode(user.email, user.password) }
      expect(response.status).to eq(201)
      expect(json(response.body)).to match(id: be_a(Integer), status: 'created', car_house: 'foo', address: 'somewhere')
    end
  end


  describe 'order#status' do
    let(:user) { User.create! email: 'l1@mycars.com', password: 'secret', level: 1, permission: true }
    let(:car) { Car.create!(levels: [2,3] , description: 'Audi A4 Avant Black Edition 2.0 TDI multitronic', price_cents: 3200000) }
    let(:car_config) { CarConfig.create!(car_id: car.id, leasing_period: 24, leasing_km: 100000, package: 'p1', leasing_rate_cents: 1000) }
    let!(:order) { car_config.orders.create(address: 'fooo', car_house: 'bar', status: 'available soon') }

    context 'success' do
      it 'tells you something about its status' do
        get "/orders/#{order.id}", {}, { 'Authorization' => encode(user.email, user.password) }
        expect(response.status).to eq(200)
        expect(json(response.body)[:status]).to eq('available soon')
      end
    end

    context 'not there' do
      it 'is four-oh-four' do
        get "/orders/1337", {}, { 'Authorization' => encode(user.email, user.password) }
        expect(response.status).to eq(404)
        expect(json(response.body)).to eq(error: 'no such order for you my friend!')
      end
    end


  end

end
