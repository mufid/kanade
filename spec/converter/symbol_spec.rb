require 'spec_helper'

RSpec.describe Kanade::Converter::Symbol do

  let(:converter) { Kanade::Converter::Symbol.new }

  let(:field_info) do
    f = Kanade::FieldInfo.new
    f.options = {}
    f
  end

  let(:mapping) do
    {
      stop: 'SRV_STOP',
      ready: 'SRV_READY'
    }
  end

  context 'can serialize' do
    subject { converter.serialize(term, field_info) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
    end

    context 'single word' do
      let(:term) { :nil }
      it { is_expected.to eq('NIL') }
    end

    context 'multiple word' do
      let(:term) { :mantap_sekali }
      it { is_expected.to eq('MANTAP_SEKALI') }
    end
  end

  context 'can deserialize' do
    subject { converter.deserialize(term, field_info) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
    end

    context 'single word' do
      let(:term) { 'NIL' }
      it { is_expected.to eq( :nil ) }
    end

    context 'multiple word' do
      let(:term) { 'MANTAP_SEKALI' }
      it { is_expected.to eq(:mantap_sekali) }
    end
  end

  context 'can serialize with mapping' do
    before { field_info.options[:mapping] = mapping }
    subject { converter.serialize(term, field_info) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
    end

    context 'single word' do
      let(:term) { :nil }
      it { is_expected.to eq('NIL') }
    end

    context 'multiple word' do
      let(:term) { :mantap_sekali }
      it { is_expected.to eq('MANTAP_SEKALI') }
    end

    context 'mapping' do
      let(:term) { :ready }
      it { is_expected.to eq('SRV_READY') }
    end
  end

  context 'can deserialize with mapping' do
    before { field_info.options[:mapping] = mapping }
    subject { converter.deserialize(term, field_info) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
    end

    context 'single word' do
      let(:term) { 'NIL' }
      it { is_expected.to eq( :nil ) }
    end

    context 'multiple word' do
      let(:term) { 'MANTAP_SEKALI' }
      it { is_expected.to eq(:mantap_sekali) }
    end

    context 'mapping' do
      let(:term) { 'SRV_READY' }
      it { is_expected.to eq(:ready) }
    end
  end

end
