require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:product) { FactoryBot.create(:product, stock: 1) }
  subject { build(:order, product: product) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a customer name" do
      subject.customer_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a address" do
      subject.address = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a zip code" do
      subject.zip_code = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a shipping method" do
      subject.shipping_method = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a product out of stock" do
      product.stock = 0
      subject.save
      subject.refresh_inventory!
      expect(subject.refresh_inventory!).to eq(false)
      expect(subject.errors.values.flatten).to include("out of stock")
    end
  end

  describe "filters" do
  end

end
