require 'spec_helper'

RSpec.describe Kanade::Converter::String do

  let(:converter) { Kanade::Converter::String.new }

  context 'can serialize' do
    subject { converter.serialize(term, nil) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
    end

    context 'nil string' do
      let(:term) { 'nil' }
      it { is_expected.to eq('nil') }
    end

    context 'real string' do
      let(:term) { 'mantaap' }
      it { is_expected.to eq('mantaap') }
    end
  end

  context 'can handle value conversion' do
    subject { converter.serialize(term, nil) }

    context 'test from int 3' do
      let(:term) { 3 }
      it { is_expected.to eq('3') }
      it { is_expected.to_not eq(3) }
    end

    context 'test from int 100' do
      let(:term) { 100 }
      it { is_expected.to eq('100') }
      it { is_expected.to_not eq(100) }
    end
  end

  context 'can deserialize' do
    subject { converter.deserialize(term, nil) }

    context 'string of number' do
      let(:term) { '100' }
      it { is_expected.to eq('100') }
    end

    context 'nil' do
      let(:term) { nil }
      it { is_expected.to be_nil }
    end

    context 'normal string' do
      let(:term) { 'Mantaaaap' }
      it { is_expected.to eq('Mantaaaap') }
    end
  end

end
