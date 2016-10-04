require 'spec_helper'

RSpec.describe Kanade::Converter::Bool do

  let(:converter) { Kanade::Converter::Bool.new }

  context 'can serialize' do
    subject { converter.serialize(term, nil) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
      it { is_expected.to_not eq('nil') }
    end

    context 'true object' do
      let(:term) { true }
      it { is_expected.to eq(true) }
      it { is_expected.to_not eq('true') }
    end

    context 'false object' do
      let(:term) { false }
      it { is_expected.to eq(false) }
      it { is_expected.to_not eq('false') }
    end
  end

  context 'can handle value conversion' do
    subject { converter.deserialize(term, nil) }

    context 'nil object' do
      let(:term) { nil }
      it { is_expected.to be_nil }
      it { is_expected.to_not eq('nil') }
    end

    context 'true string' do
      let(:term) { 'true' }
      it { is_expected.to eq(true) }
      it { is_expected.to_not eq('true') }
    end

    context 'true object' do
      let(:term) { true }
      it { is_expected.to eq(true) }
      it { is_expected.to_not eq('true') }
    end

    context 'false string' do
      let(:term) { 'false' }
      it { is_expected.to eq(false) }
      it { is_expected.to_not eq('false') }
    end

    context 'false object' do
      let(:term) { false }
      it { is_expected.to eq(false) }
      it { is_expected.to_not eq('false') }
    end
  end

end
