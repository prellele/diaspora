module FinancesHelper

  def totalfinances
  	return 0 unless Revenue.all.present? && Expense.all.present?
    Revenue.all.map {|revenue| revenue.sumvalues}.inject(:+) - Expense.all.map {|expense| expense.sumvalues}.inject(:+) 
  end

end
