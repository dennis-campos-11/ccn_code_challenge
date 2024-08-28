require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include Helpers::Authentication

  describe "When user is authenticated" do
    before do
      user = FactoryBot.create(:user)
      sign_in_as(user)
    end

    it 'should create a new product' do
      product_attributes = FactoryBot.attributes_for(:product)
      post :create, params: { product: product_attributes }

      expect(response).to have_http_status(302)
      expect(Product.count).to eq(1)
    end

    it 'should update an existing product' do
      product = FactoryBot.create(:product)
      post :update, params: { product: { stock: 1000 }, id: product.id }

      product.reload
      expect(response).to have_http_status(302)
      expect(Product.count).to eq(1)
      expect(product.stock).to eq(1000)
    end

    it 'should show the list of products' do
      get :index

      expect(response).to have_http_status(200)
    end

    it 'should show the details of the product' do
      product = FactoryBot.create(:product)
      get :show, params: { id: product.id }

      expect(response).to have_http_status(200)
    end

    it 'should destroy the product' do
      product = FactoryBot.create(:product)
      delete :destroy, params: { id: product.id }

      expect(response).to have_http_status(302)
      expect(Product.count).to eq(0)
    end
  end

  describe "When user is NOT authenticated" do
    it 'should NOT create a new product and redirect to new session path' do
      product_attributes = FactoryBot.attributes_for(:product)
      post :create, params: { product: product_attributes }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_session_path)
    end

    it 'should NOT allow access the list of products and redirect to new session path' do
      get :index

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_session_path)
    end

    it 'should NOT destroy the product and redirect to new session path' do
      product = FactoryBot.create(:product)
      delete :destroy, params: { id: product.id }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_session_path)
    end
  end

end