require 'spec_helper'
require_relative '../fixtures/product'
require_relative '../fixtures/product_wrong'

RSpec.describe 'Serialization Integration' do

  before(:all) do
    # Make sure everything has been cleaned up
    raise StandardError unless @engine.nil?

    @engine = Kanade::Engine.new
    @engine.configure do |config|
      config.contract = :camel_case
      config.enum = :upper_snake_case
    end
  end

  context 'Single Product' do

    def populate(product)
      product.id = 101
      product.name = 'Super Duper Enak'
      product.expire_at = 'Tue, 10 Oct 2017 06:52:44 GMT+7'
      product.available = nil
      product.price = 11

      product
    end

    let(:target) do
      populate(Product.new)
    end

    let(:target_wrong) do
      populate(ProductWrong.new)
    end

    it 'can serialize correctly' do
      result = @engine.serialize(target)
      expect(result).to be_json_of(:simple_product)
    end

    it 'can handle value conversion' do
      target.id = "101"
      result = @engine.serialize(target)
      expect(result).to be_json_of(:simple_product)
    end

    it 'should be fail when a field is set null' do
      target.price = nil
      result = @engine.serialize(target)
      expect(result).to_not be_json_of(:simple_product)
    end

    it 'should be fail when a field is set differently' do
      target.price = 3232
      result = @engine.serialize(target)
      expect(result).to_not be_json_of(:simple_product)
    end

    it 'should be fail when data type is wrong' do
      result = @engine.serialize(target_wrong)
      expect(result).to_not be_json_of(:simple_product)
    end
  end

  context 'Array of products' do

  end
end
