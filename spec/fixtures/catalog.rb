class Catalog < Kanade::Dto
  field :id, as: :fixnum
  field :serials, as: :list, of: :fixnum
  field :products, as: :list, of: Product
end
