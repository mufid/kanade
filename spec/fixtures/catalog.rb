class Catalog < Kanade::Dto
  field :id, as: :fixnum
  field :products, as: :list, of: :fixnum
end
