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
      # TODO Do not use ISO8601. Natural date seems broken in Ruby,
      # but serialization should be seamless. It should work on
      # our own, too!
      # product.expire_at = 'Tue, 10 Oct 2017 06:52:44 GMT+9'
      product.expire_at = '2017-10-10T06:52:44+09:00'
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
    subject { @engine.serialize(target) }

    let(:target) do
      catalog = Catalog.new
      catalog.serials = [100, 105, 444]
      catalog.id = 3

      product1 = Product.new
      product1.id = 100
      product1.name = 'Cat Plushie'
      product1.expire_at = nil
      product1.price = '19.95'
      product1.available = true

      product2 = Product.new
      product2.id = 101
      product2.name = 'Taco'
      product2.expire_at = '2016-09-21T13:52:44+07:00'
      product2.price = 5
      product2.available = true

      catalog.products = []
      catalog.products << product1
      catalog.products << product2
      catalog
    end

    it { is_expected.to be_json_of(:catalog_camel_case) }
  end

  context 'Nested object' do
  end
end
