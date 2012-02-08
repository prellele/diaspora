class Type < FinanceBase

  has_many :revenues

  attr_accessible :id,
                  :name

end

