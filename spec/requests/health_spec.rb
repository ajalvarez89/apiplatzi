require 'rails_helper'

# prueba de integracion, para probar desde principio a fin, verifica todos los componentes ":request"
RSpec.describe 'Health endpoint', type: :request do 
  
  describe 'GET /health' do
    before { get '/healt' }

    #response tendra la respuesta , body = el cuerpo de la respuesta http
    it 'should return OK' do 
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['api']).to eq('OK')
    end

    it 'should return status code 200' do 
      expect(response).to have_http_status(200)
    end
  
  end
end