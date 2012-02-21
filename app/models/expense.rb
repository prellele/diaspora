class Expense < FinanceBase

  belongs_to :type

  attr_accessible :id,
                  :description,
                  :date,
                  :value
                  :type_id

end

