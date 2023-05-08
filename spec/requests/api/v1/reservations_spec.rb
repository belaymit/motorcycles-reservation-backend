require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/users/{user_id}/reservations' do
    get 'Display User Motorcycle Reservation' do
      tags 'Motorcycle Reservation'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, description: 'Current User ID'

      response '200', 'Display Reservation Successfully.' do
        before do
          @user = User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                              password_confirmation: '123456')
          sign_in @user
          @motorcycle = Motorcycle.create(
            name: 'Vespa Scooter-Authotrader',
            image: 'https://1.cdn.autotraderspecialty.com/Article-1000000003-5ca78614aab09bd072e32f2bc9373a3b.jpg',
            description: 'From their inception, Vespa scooters have been known for their painted, pressed steel',
            price: 4_000,
            category: 'Vespa 125cc'
          )
          start_date = Date.today
          end_date = Date.today + 5
          Reservation.create(motorcycle_id: @motorcycle.id, start_date:, end_date:)
        end

        let(:user_id) { @user.id }
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   start_date: { type: :date },
                   end_date: { type: :date },
                   motorcycle: { type: :object,
                                 properties: {
                                   id: { type: :integer },
                                   name: { type: :string },
                                   category: { type: :string },
                                   image: { type: :string },
                                   price: { type: :decimal },
                                   description: { type: :string }
                                 }, required: %w[id name category image price description] }
                 },
                 required: %w[user_id motorcycle_id start_date end_date]
               }
        run_test!
      end

      response '401', 'Invalid Record not found' do
        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end
  path '/api/v1/users/{user_id}/reservations' do
    post 'Create Reservation' do
      tags 'Create Reservation'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer, description: 'Current User ID'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          motorcycle_id: { type: :integer },
          start_date: { type: :date },
          end_date: { type: :date }
        },
        required: %w[user_id motorcycle_id start_date end_date]
      }

      response '201', 'Created Reservation Successfully.' do
        before do
          @user = User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                              password_confirmation: '123456')
          sign_in @user
          @motorcycle = Motorcycle.create(
            name: 'Vespa Scooter-Authotrader',
            image: 'https://1.cdn.autotraderspecialty.com/Article-1000000003-5ca78614aab09bd072e32f2bc9373a3b.jpg',
            description: 'From their inception, Vespa scooters have been known for their painted, pressed steel',
            price: 4_000,
            category: 'Vespa 125cc'
          )
          start_date = Date.today
          end_date = Date.today + 5
          Reservation.create(motorcycle_id: @motorcycle.id, start_date:, end_date:)
        end
        let(:user_id) { @user.id }
        start_date = Date.today
        end_date = Date.today + 5
        let(:reservation) { { reservation: { user_id: @user.id, motorcycle_id: @motorcycle.id, start_date:, end_date: } } }
        run_test!
      end

      response '401', 'Invalid request' do
        let(:user_id) { 'invalid' }
        let(:reservation) do
          { reservation: { user_id: 'invalid', motorcycle_id: 'invalid', start_date: 'invalid', end_date: 'invalid' } }
        end
        run_test!
      end
    end
  end
  path '/api/v1/users/{user_id}/reservations/{id}' do
    delete 'Delete Motorcycle Reservation' do
      tags 'Delete Reservation'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer, description: 'Current User ID'
      parameter name: :id, in: :path, type: :integer, description: 'Reservation ID'

      response '200', 'Reservation Deleted Successfully.' do
        before do
          @user = User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                              password_confirmation: '123456')
          sign_in @user
          @motorcycle = Motorcycle.create(
            name: 'Vespa Scooter-Authotrader',
            image: 'https://1.cdn.autotraderspecialty.com/Article-1000000003-5ca78614aab09bd072e32f2bc9373a3b.jpg',
            description: 'From their inception, Vespa scooters have been known for their painted, pressed steel',
            price: 4_000,
            category: 'Vespa 125cc'
          )
          start_date = Date.today
          end_date = Date.today + 5
          @reservation = Reservation.create(motorcycle_id: @motorcycle.id, start_date:, end_date:, user_id: @user.id)
        end

        let(:user_id) { @user.id }
        let(:id) { @reservation.id }
        run_test!
      end
    end
  end
end
