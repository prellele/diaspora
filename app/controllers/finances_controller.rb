class FinancesController < ApplicationController
  before_filter :authenticate_user!

  def index
    onetime = [1,3,4,5]
    @onetimee_revenues = Revenue.where(:type_id => [1,3,4,5])
    @monthlyy_revenues = Revenue.where(:type_id => 2)
    @sum_revenues = Revenue.sum("value")
    @sum_expenses = Expense.sum("value")
    @expenses = Expense.joins("left join `types` t ON t.id = type_id").select("expenses.description,min(expenses.date) as mindate,max(expenses.date) as maxdate,t.name,value,sum(expenses.value) as totalvalue, COUNT(value) as anzahl").group('expenses.value, expenses.description')
    @onetime_revenues =  Revenue.where('t.id in (?)', onetime).joins("left join `types` t ON t.id = type_id").select("revenues.description,revenues.date,revenues.value,t.name")
    @monthly_revenues =  Revenue.where('t.id not in (?)', onetime).joins("left join `types` t ON t.id = type_id").select("revenues.description,revenues.date,sum(revenues.value) as value,t.name,COUNT(spender) as anzahl").group('revenues.spender')
    @total= @sum_expenses - @sum_revenues
  end

end

