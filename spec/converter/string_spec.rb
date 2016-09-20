require 'spec_helper'

RSpec.describe Kanade::Converter::String do
  subject { Kanade::Converter::String.new }

  it 'can serialize' do
    expect(subject.serialize(nil)).to be_nil
    expect(subject.serialize('nil')).to eq('nil')
    expect(subject.serialize('mantaap')).to eq('mantaap')
  end

  it 'can handle value conversion' do
    expect(subject.deserialize(3)).to eq('3')
    expect(subject.deserialize(3)).to_not eq(3)
    expect(subject.deserialize(100)).to_not eq(100)
    expect(subject.deserialize(100)).to eq('100')
  end

  it 'can deserialize' do
    expect(subject.deserialize('100')).to eq('100')
    expect(subject.deserialize(nil)).to eq(nil)
    expect(subject.deserialize('Mantaaaap')).to eq('Mantaaaap')
  end
end
