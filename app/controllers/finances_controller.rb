class FinancesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @expenses = Expense.all
    @onetime_revenues = Revenue.where(:type_id => [1,3,4,5])
    @monthly_revenues = Revenue.where(:type_id => 2)
    @sum_revenues = Revenue.sum("value")
    @sum_expenses = Expense.sum("value")
  end
  
end

