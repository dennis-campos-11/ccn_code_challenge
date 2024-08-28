require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  include Helpers::Authentication

  describe "When user is authenticated" do
    before do
      user = FactoryBot.create(:user)
      sign_in_as(user)
    end

    it 'should show the list of orders' do
      get :index

      expect(response).to have_http_status(200)
    end

    it 'should destroy the order' do
      order = FactoryBot.create(:order)
      delete :destroy, params: { id: order.id }

      expect(response).to have_http_status(302)
      expect(Order.count).to eq(0)
    end
  end

  describe "When user is NOT authenticated" do
    it 'should allow to create a new order' do
      get :index

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_session_path)
    end
  end

end