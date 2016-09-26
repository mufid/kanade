require 'spec_helper'

class Udang < Kanade::Dto
  field :shrimp, as: :string
end

class Cumi < Kanade::Dto
  field :edible, as: :bool
end

RSpec.describe 'Class Consistency' do
  it 'does not respond to non-responding method' do
    expect(Cumi.new).to_not respond_to(:edible)
    expect(Udang.new).to_not respond_to(:shrimp)
    expect(Kanade::Dto.new).to_not respond_to(:shrimp)
    expect(Kanade::Dto.new).to_not respond_to(:edible)
  end
end
