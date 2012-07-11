class Expense < FinanceBase

  belongs_to :type

  attr_accessible :id,
                  :description,
                  :date,
                  :value,
                  :type_id,
                  :till

  def sumvalues
    sumvalues = self.months * value
  end

  def months
    if type_id == 12
      months = (till.nil?) ? (Time.now.month-date.month) : till.month-date.month
      months += 1
      months += (till.nil?) ? 12*(Time.now.year-date.year) : 12*(till.year-date.year)
    elsif type_id == 11
      months = (till.nil?) ? (Time.now.year-date.year) : 12*(till.year-date.year)
      months += 1
    elsif type_id == 10
      months = 1
    end
  end

end

