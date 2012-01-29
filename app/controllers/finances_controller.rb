class FinancesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @expenses = Expense.all
  end
  
end
