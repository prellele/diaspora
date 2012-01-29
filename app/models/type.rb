class Type < FinancesBase

  has_many :revenues

  attr_accessible :id,
                  :name

end
