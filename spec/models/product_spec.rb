require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build :product }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a stock" do
    subject.stock = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with negative stock" do
    subject.stock = -1
    expect(subject).to_not be_valid
  end
end
