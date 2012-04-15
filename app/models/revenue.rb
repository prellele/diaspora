class Revenue < FinanceBase

  belongs_to :type

  attr_accessible :id,
                  :description,
                  :date,
                  :value,
                  :spender,
                  :type_id

end

