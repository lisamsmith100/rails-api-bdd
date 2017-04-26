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
      # setup
      articles_collection = JSON.parse(response.body)

      # action

      # assert
      expect(articles_collection).not_to be_nil
      expect(articles_collection.first['title']).to eq(article['title'])
      # teardown
    end
  end

  describe 'GET show' do
    before(:each) do
      get :show, params: { id: article.id }
    end

    it 'is successful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      # setup
      article_response = JSON.parse(response.body)
      expect(article_response).not_to be_nil
      # this test is simple--response is not nil
      # expect(article_response.first['title']).to eq(article['title'])
      # expects {} octet
    end
  end

  describe 'DELETE destroy' do
    skip 'is successful and returns an empty response' do
    end
  end

  describe 'PATCH update' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    before(:each) do
      patch :update, id: article.id,
                     params: { article: article_diff }
    end

    skip 'is successful' do
    end

    skip 'renders a JSON response' do
    end
  end

  describe 'POST create' do
    before(:each) do
      post :create, params: { article: article_params }
    end

    skip 'is successful' do
    end

    skip 'renders a JSON response' do
    end
  end
end
