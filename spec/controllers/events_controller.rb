require 'rails_helper'
include Devise::TestHelpers
include JSON_helper

RSpec.describe API::EventsController, type: :controller do
  let(:user) { create(:user) }
  describe '#create' do
    before do
      @app = create(:registered_application, user: user)
    end
    context 'Registered Application' do
      before do
        request.env['HTTP_ORIGIN'] = @app.url
      end
      it 'responds with status created' do
        post :create, name: 'score'
        expect(response).to have_http_status(:created)
      end
      it 'responds with 201' do
        post :create, name: 'score'
        expect(response.status).to eq(201)
      end
      it 'object has correct name' do
        post :create, name: 'score'
        expect(response_in_json['name']).to eq('score')
      end
      it 'object has parent registered_application' do
        post :create, name: 'score'
        expect(response_in_json['registered_application_id']).to eq(@app.id)
      end
      context 'Invalid attributes' do
        context 'No name' do
          it 'responds with appropriate message' do
            post :create, name: ''
            expect(response_in_json['errors'][0]).to eq('Name can\'t be blank')
          end
          it 'responds with 422' do
            post :create, name: ''
            expect(response.status).to eq(422)
          end
        end
      end
    end
    context 'Unregistered Application' do
      before do
        request.env['HTTP_ORIGIN'] = 'nowear.com'
      end
      it 'responds with status unprocessable entity' do
        post :create, name: 'miss'
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'responds with 422' do
        post :create, name: 'miss'
        expect(response.status).to eq(422)
      end
      it 'responds with appropriate message' do
        post :create, name: 'miss'
        expect(response_in_json['errors'][0]).to eq('Registered application missing')
      end
    end
  end
end

