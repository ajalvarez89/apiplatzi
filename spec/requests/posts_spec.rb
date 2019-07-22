require 'rails_helper'

# prueba de integracion, para probar desde principio a fin, verifica todos los componentes ":request"
RSpec.describe 'Posts', type: :request do 
  
  describe 'GET /Posts' do
    before { get '/post' }

    #response tendra la respuesta , body = el cuerpo de la respuesta http
    it 'should return OK' do 
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe 'with data in the DB' do
    before { get '/post' }

    let(:posts) {create_list(:post, 10, published: true)}
    it 'should return all the published posts' do 
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /post/{id}" do
    let(:post) { create(:post)}
    
    it 'should return a post' do 
      get "/post/#{post.id}" 
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(post.id)
      expect(response).to have_http_status(200)
    end
  end

end