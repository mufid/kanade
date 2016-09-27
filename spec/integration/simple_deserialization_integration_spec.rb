require 'spec_helper'
require_relative '../fixtures/product'
require_relative '../fixtures/product_wrong'

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

  end
end
