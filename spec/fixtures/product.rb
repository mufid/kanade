class Product < Kanade::Dto
  field :id, as: :fixnum
  field :name, as: :string
  field :expire_at, as: :date_time
  field :price, as: :big_decimal
  field :available, as: :bool
end
