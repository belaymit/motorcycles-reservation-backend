require 'swagger_helper'

RSpec.describe 'api/v1/login', type: :request do
  path '/api/v1/login' do
    post 'Log in User' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'Logged in Successfully.' do
        before do
          User.create(name: 'Belay', email: 'belay@gmail.com', password: '123456',
                      password_confirmation: '123456')
        end
        let(:user) { { user: { email: 'belay@gmail.com', password: '123456' } } }
        run_test!
      end

      response '401', 'Invalid Credentials.' do
        let(:user) do
          { user: { name: 'Belay Birhanu' } }
        end
        run_test!
      end
    end
  end
end
