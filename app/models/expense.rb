class Expense < FinanceBase

  belongs_to :type

  attr_accessible :id,
                  :description,
                  :date,
                  :value,
                  :type_id,
                  :till

  def months
    months = (till.nil?) ? Time.now.month-date.month : till.month-date.month
  end
  
  def years
    years = Time.now.year-date.year 
    years += 1 if years <0 
    years+1
  end

end

