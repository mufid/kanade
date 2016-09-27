class RefundReport
  field :refund_id, as: :fixnum, with: 'ID'
  field :affected_product, as: Product
end
