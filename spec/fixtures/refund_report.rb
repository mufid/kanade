class RefundReport < Kanade::Dto
  field :refund_id, as: :fixnum, with: 'ID'
  field :affected_product, as: Product
  field :addendum_report, as: RefundReport
end
