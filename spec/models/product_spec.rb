require 'rails_helper'

# RSpec.describe Product, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new(name: "Electronics")
      @product = Product.new(:name => "Solar Torch", :price_cents => 3400, :quantity => 12, :category => @category)
    end

    it 'should have saved' do
      @product.save
      expect(@product.id).to be_present
    end

    it 'should have a name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

    it 'should have a price' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it 'should have a quantity' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end

    it 'should have a category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end

  end
end
