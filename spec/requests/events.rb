require 'rails_helper'
include JSONhelper

RSpec.describe API::EventsController, type: :request do
  let(:user) { create(:user) }
  describe '#create' do
    before do
      @app = create(:registered_application, user: user)
    end
    context 'Registered Application' do
      it 'responds with status created' do
        post '/api/events', { name: 'score' }, 'HTTP_ORIGIN' => @app.url
        expect(response).to have_http_status(:created)
      end
      it 'object has correct name' do
        post '/api/events', { name: 'score' }, 'HTTP_ORIGIN' => @app.url
        expect(response_in_json['name']).to eq('score')
      end
      it 'object has parent registered_application' do
        post '/api/events', { name: 'score' }, 'HTTP_ORIGIN' => @app.url
        expect(response_in_json['registered_application_id']).to eq(@app.id)
      end
      context 'Invalide attributes' do
        context 'No name' do
          it 'returns appropriate message' do
            post '/api/events', { name: '' }, 'HTTP_ORIGIN' => @app.url
            expect(response_in_json['errors'][0]).to eq('Name can\'t be blank')
          end
          it 'returns 422' do
            post '/api/events', { name: '' }, 'HTTP_ORIGIN' => @app.url
            expect(response.status).to eq(422)
          end
        end
      end
    end
    context 'Unregistered application' do
      it 'responds with unprocessable entity' do
        post '/api/events', { name: 'miss' }, 'HTTP_ORIGIN' => 'nowear.com'
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'responds with 422' do
        post '/api/events', { name: 'miss' }, 'HTTP_ORIGIN' => 'nowear.com'
        expect(response.status).to eq(422)
      end
      it 'responds with appropriate message' do
        post '/api/events', { name: 'miss' }, 'HTTP_ORIGIN' => 'nowear.com'
        expect(response_in_json['errors'][0]).to eq('Registered application missing')
      end
    end
  end
end
