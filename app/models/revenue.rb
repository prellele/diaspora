class Revenue < FinanceBase

  belongs_to :type

  attr_accessible :id,
                  :description,
                  :date,
                  :value,
                  :spender,
                  :type_id,
                  :till
                  
  def sumvalues
    sumvalues = months * value
  end
  
  def months
    if type_id == 2
      months = (till.nil?) ? (Time.now.month-date.month) : till.month-date.month
      months += 1
      months += (till.nil?) ? 12*(Time.now.year-date.year) : 12*(till.year-date.year)
    else
      months = 1
    end
  end
  
end

