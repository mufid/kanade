require 'spec_helper'

describe Kanade::NamingStrategy::CamelCase do
  subject do
    Kanade::NamingStrategy::CamelCase.new
  end

  it 'can serialize' do
    expect(subject.serialize(:camel_case)).to eq('camelCase')
    expect(subject.serialize(:oneword)).to eq('oneword')
  end

  it 'can deserialize' do
    expect(subject.deserialize('camelCase')).to eq(:camel_case)
    expect(subject.deserialize('oneword')).to eq(:oneword)
  end

  it 'does not understand dictionary' do
    expect(subject.serialize(:xml_serializer)).to eq('xmlSerializer')
    expect(subject.deserialize('xmlSerializer')).to eq(:xml_serializer)
    expect(subject.deserialize('XMLSerializer')).to eq(:xml_serializer)
  end
end
