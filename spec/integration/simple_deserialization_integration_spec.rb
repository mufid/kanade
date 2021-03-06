require 'spec_helper'
require_relative '../fixtures/product'
require_relative '../fixtures/product_wrong'
require_relative '../fixtures/refund_report'
require_relative '../fixtures/catalog'

RSpec.describe 'Deserialization Integration' do

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

    let(:object) do
      @engine.deserialize(Product, json_of(:simple_product))
    end

    context 'correct id' do
      subject { object.id }
      it { is_expected.to eq(101) }
      it { is_expected.not_to eq('101') }
    end

    context 'correct name' do
      subject { object.name }
      it { is_expected.to eq('Super Duper Enak') }
    end

    context 'correct time conversion' do
      subject { object.expire_at }
      it { is_expected.to eq(Time.parse('2017-10-10T06:52:44+09:00')) }
      it { is_expected.to_not eq(Time.parse('2017-10-10T06:52:44+08:00')) }
      it { is_expected.to_not eq(Time.parse('2017-10-09T19:52:44+00:00')) }
    end

    context 'correct price' do
      subject { object.price }
      it { is_expected.to eq(BigDecimal.new(11))}
      it { is_expected.to eq(BigDecimal.new('11.0'))}
      it { is_expected.to_not eq(BigDecimal.new('1.1'))}
    end

    context 'correct availability' do
      subject { object.available }
      it { is_expected.to be_nil }
    end
  end

  context 'Array of products' do
    let(:object) do
      @engine.deserialize(Catalog, json_of(:catalog_camel_case))
    end

    subject do
      object
    end

    it 'has correct id' do
      expect(subject.id).to eq(3)
      expect(subject.id).to_not eq('3')
    end

    it 'has serials of fixnum' do
      expect(subject.serials).to eq([100, 105, 444])
      expect(subject.serials).to_not eq([100, '105', 444])
    end

    it 'has multiple products' do
      expect(subject.products.count).to eq(2)
    end

    it 'has correct order of products' do
      expect(subject.products[0].id).to eq(100)
      expect(subject.products[0].name).to eq('Cat Plushie')
      expect(subject.products[0].expire_at).to be_nil
      expect(subject.products[0].price).to eq(BigDecimal.new('19.95'))
      expect(subject.products[0].price).to_not eq('19.95')
      expect(subject.products[0].available).to eq(true)

      expect(subject.products[1].id).to eq(101)
      expect(subject.products[1].name).to eq('Taco')
      expect(subject.products[1].expire_at).to eq(Time.parse('2016-09-21T13:52:44+07:00'))
      expect(subject.products[1].price).to eq(BigDecimal.new('5.0'))
      expect(subject.products[1].price).to_not eq('5.0')
      expect(subject.products[1].available).to eq(true)
    end
  end

  context 'Nested object' do
    let(:object) do
      @engine.deserialize(RefundReport, json_of(:refund_report))
    end

    subject do
      object
    end

    it 'has correct ID' do
      expect(subject.refund_id).to eq(9321)
    end

    it 'has correct nested product' do
      expect(subject.affected_product.id).to eq(451)
      expect(subject.affected_product.name).to eq('Digital Camera')
      expect(subject.affected_product.expire_at).to eq(Time.parse('2019-03-30T06:52:44+09:00'))
      expect(subject.affected_product.price).to eq(BigDecimal.new('99.95'))
      expect(subject.affected_product.available).to eq(true)
    end

    it 'has correct addendum report' do
      expect(subject.addendum_report.refund_id).to eq(1234)
      expect(subject.addendum_report.affected_product).to be_nil
      expect(subject.addendum_report.addendum_report).to be_nil
    end
  end
end
