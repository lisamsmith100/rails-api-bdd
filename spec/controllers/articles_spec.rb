# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ArticlesController do
  def article_params
    {
      title: 'One Weird Trick',
      content: 'You won\'t believe what happens next...'
    }
  end

  def article
    Article.first
  end

  before(:all) do
    Article.create!(article_params)
  end

  after(:all) do
    Article.delete_all
  end

  describe 'GET index' do
    before(:each) do
      get :index
    end
    it 'is succesful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do

      # sets up response
      articles_collection = JSON.parse(response.body)
      # setup

      # act

      # assert
      expect(articles_collection).not_to be_nil
      expect(articles_collection.first['title']).to eq(article['title'])
      # teardown
    end
  end

  describe 'GET show' do
    before(:each) do
      get :show, params: {id: article.id}
    end
    it 'is successful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      article_response =  JSON.parse(response.body)
      p article_response
      p response
      # setup

      # act

      # assert
      expect(article_response).not_to be_nil
    end
  end

  describe 'DELETE destroy' do
    it 'is successful and returns an empty response' do
      delete :destroy, params: { id: article.id}

      expect(response).to be_success
      expect(response.body).to be_empty

    end
  end

  describe 'PATCH update' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    before(:each) do
      patch :update,
                     params: { id: article.id, article: article_diff }
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'returns an empty response' do
      # article_response= JSON.parse(response.body)
      #expect(article_response).not_to be_nil
      #expect(article_response).to eq(article_diff[:title])
      expect(response.body).to be_empty
    end
  end

  describe 'POST create' do
    before(:each) do
      post :create, params: { article: article_params }
    end

    it 'is successful' do
      expect(response.status).to eq(201)
    end

    it 'renders a JSON response' do
      new_article =  JSON.parse(response.body)
      p new_article
      expect(new_article).not_to be_nil
    end
  end
end
