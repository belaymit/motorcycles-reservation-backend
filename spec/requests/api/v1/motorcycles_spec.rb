require 'swagger_helper'

RSpec.describe 'api/v1/motorcycles', type: :request do
  path '/api/v1/motorcycles' do
    get 'Display Motorcycles' do
      tags 'Motorcycles'
      produces 'application/json'

      response '200', 'Motorcycles displayed' do
        before do
          @user = User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                              password_confirmation: '123456')
          sign_in @user

          Motorcycle.create(
            name: 'Gas Scooter Moped Bike',
            image: 'https://image.made-in-china.com/155f0j00qfhUtJVGTauL/Vespa-Type-125cc-Gas-Scooter-Moped-Bike.jpg',
            description: 'Vespa is an Italian luxury brand of scooters and mopeds manufactured by Piaggio',
            price: 12_000,
            category: 'Vespa 50cc'
          )
        end

        schema type: :array,
               properties: {
                 name: { type: :string },
                 image: { type: :string },
                 description: { type: :string },
                 price: { type: :string },
                 category: { type: :string }
               },
               required: %w[name image description price category]
        run_test!
      end
    end
  end

  path '/api/v1/motorcycles/{id}' do
    get 'Display Single Motorcycle Details' do
      tags 'Display Motorcycle Details'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', "Motorcycle's details is displayed" do
        before(:each) do
          @user = User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                              password_confirmation: '123456')
          sign_in @user
          @motorcycle = Motorcycle.create(
            name: 'Gas Scooter Moped Bike',
            image: 'https://image.made-in-china.com/155f0j00qfhUtJVGTauL/Vespa-Type-125cc-Gas-Scooter-Moped-Bike.jpg',
            description: 'Vespa is an Italian luxury brand of scooters and mopeds manufactured by Piaggio',
            price: 12_000,
            category: 'Vespa 50cc'
          )
        end

        schema type: :object,
               properties: {
                 name: { type: :string },
                 image: { type: :string },
                 description: { type: :string },
                 price: { type: :decimal },
                 category: { type: :string }
               },
               required: %w[name image description price category]
        let(:id) { @motorcycle.id }
        run_test!
      end
    end
  end

  path '/api/v1/motorcycles' do
    post 'Create a Motorcycle' do
      tags 'Create Motorcycle'
      consumes 'application/json'
      parameter name: :motorcycle, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          image: { type: :string },
          description: { type: :string },
          price: { type: :decimal },
          category: { type: :string }
        },
        required: %w[name image description price category]
      }

      response '201', 'Motorcycle Created Successfully' do
        before do
          @user = User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                              password_confirmation: '123456')
          sign_in @user

          Motorcycle.create(
            name: 'Gas Scooter Moped Bike',
            image: 'https://image.made-in-china.com/155f0j00qfhUtJVGTauL/Vespa-Type-125cc-Gas-Scooter-Moped-Bike.jpg',
            description: 'Vespa is an Italian luxury brand of scooters and mopeds manufactured by Piaggio',
            price: 12_000,
            category: 'Vespa 50cc'
          )
        end

        let(:motorcycle) { { motorcycle: { name: 'Gas Scooter Moped Bike', category: 'Vespa 75cc', description: 'here is some description', price: 100, image: 'https://image.made-in-china.com/155f0j00qfhUtJVGTauL/Vespa-Type-125cc-Gas-Scooter-Moped-Bike.jpg' } } }
        run_test!
      end

      response '401', 'Invalid request' do
        let(:motorcycle) { { motorcycle: { name: 'Vespa 75' } } }
        run_test!
      end
    end
  end
end
