require 'rails_helper'

# prueba de integracion, para probar desde principio a fin, verifica todos los componentes ":request"
RSpec.describe 'Posts', type: :request do 
  
  describe 'GET /posts' do
    before { get '/posts' }

    #response tendra la respuesta , body = el cuerpo de la respuesta http
    it 'should return OK' do 
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end
#test
  describe 'with data in the DB' do
    let!(:posts) {create_list(:post, 10, published: true)}
    before { get '/posts' }

    it 'should return all the published posts' do   
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts/{id}" do
    let(:post) { create(:post)}
    
    it 'should return a post' do 
      get "/posts/#{post.id}" 
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(post.id)
      expect(response).to have_http_status(200)
    end
  end

  #test POST
  describe "POST /posts" do 
    let!(:user) {create(:user)}
    it 'should create a post' do 
      req_payload = {
        post: {
          title:'title',
          content: 'content',
          published: false,
          user_id: user.id
       }
      }

      post '/posts', params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it 'should return error message on invalid POST post' do 
      req_payload = {
        post: {
          content: "content",
          published: false,
          user_id: user.id
       }
      }
      #POST HTTP
      post '/posts', params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end 

  # test PUT
  describe "PUT /posts/{id}" do 
    let!(:article) {create(:post)}

    it 'should update a post' do 
      req_payload = {
        post: {
          title:'title',
          content: 'content',
          published: true
        }
      }

      #PUT HTTP
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(article.id)
      expect(response).to have_http_status(:ok)
    end

    it 'should return error message on invalid PUT post' do 
      req_payload = {
        post: {
          title: nil,
          content: nil,
          published: false,
       }
      }

      #PUT HTTP
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not eq(article.id)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end 
end