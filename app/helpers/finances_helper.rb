module FinancesHelper

  def totalfinances
    Revenue.all.map {|revenue| revenue.sumvalues}.inject(:+) - Expense.all.map {|expense| expense.sumvalues}.inject(:+)
  end

end
