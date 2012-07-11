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
    sumvalues = self.months * value
  end
  
  def months
    months = (till.nil?) ? Time.now.month-date.month : till.month-date.month
  end

end

