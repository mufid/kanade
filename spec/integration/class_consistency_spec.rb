require 'spec_helper'

class Udang < Kanade::Dto
  field :shrimp, as: :string
end

class Cumi < Kanade::Dto
  field :edible, as: :bool
end

class Mangga < Kanade::Dto
  field :edible, as: :string
end

class ManggaBali < Mangga
  field :color, as: :string
  field :available, as: :bool
end

RSpec.describe 'Class Consistency' do
  it 'does not respond to non-responding method' do
    expect(Cumi.new).to respond_to(:edible)
    expect(Udang.new).to respond_to(:shrimp)
    expect(Kanade::Dto.new).to_not respond_to(:shrimp)
    expect(Kanade::Dto.new).to_not respond_to(:edible)
  end
  it 'behave with correct field' do
    cumi = Cumi.new
    cumi.edible = true
    mangga = Mangga.new
    mangga.edible = 'yes'

    expect(cumi.edible).to eq(true)
    expect(mangga.edible).to eq('yes')
  end
  it 'behave with correct inheritance' do
    m = ManggaBali.new
    m.available = 'true'
    m.edible = 'yes'

    expect(m.available).to eq(true)
    expect(m.edible).to eq('yes')
  end
end
