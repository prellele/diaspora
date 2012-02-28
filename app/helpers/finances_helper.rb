module FinancesHelper

  def effective_expenses
    @@effective_expenses ||= Revenue.sum("value") - Expense.sum("value")
  end

end
