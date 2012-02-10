class FinancesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    onetime = [1,3,4,5] 
    @expenses = Expense.all
    @onetimee_revenues = Revenue.where(:type_id => [1,3,4,5])
    @monthlyy_revenues = Revenue.where(:type_id => 2)
    @sum_revenues = Revenue.sum("value")
    @sum_expenses = Expense.sum("value")
    @onetime_revenues =  Revenue.where('t.id in (?)', onetime).joins("left join `types` t ON t.id = type_id").select("revenues.description,revenues.date,revenues.value,t.name")
    @monthly_revenues =  Revenue.where('t.id not in (?)', onetime).joins("left join `types` t ON t.id = type_id").select("revenues.description,revenues.date,revenues.value,t.name")
  end
  
end

