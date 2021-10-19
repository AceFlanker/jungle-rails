require 'rails_helper'

# RSpec.describe Product, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.create(name: "Electronics")
      @product = Product.create(:name => "Solar Torch", :price_cents => 3400, :quantity => 12, :category => @category)
    end

    it 'should have saved' do
      expect(@product.id).to be_present
    end

    it 'should not have saved without a name' do
      @product.update(name: nil)
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

    it 'should not have saved without a price' do
      @product.update(price_cents: nil)
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it 'should not have saved without a quantity' do
      @product.update(quantity: nil)
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end

    it 'should not have saved without a category' do
      @product.update(category: nil)
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end

  end
end
