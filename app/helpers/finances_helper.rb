module FinancesHelper

  def effective_expenses
    @@effective_expenses ||= Expense.sum("value") - Revenue.sum("value")
    return @@effective_expenses
  end

end
