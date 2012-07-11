class FinancesController < ApplicationController
  before_filter :authenticate_user!

  def index
    onetime = [1,3,4,5]
    @expenses = Expense.joins("left join `types` t ON t.id = type_id").select("date, expenses.description,t.name,value,till,type_id")
    @onetime_revenues =  Revenue.where('t.id in (?)', onetime).joins("left join `types` t ON t.id = type_id").select("revenues.description,revenues.date,revenues.value,t.name,type_id")
    @monthly_revenues =  Revenue.where('t.id not in (?)', onetime).joins("left join `types` t ON t.id = type_id").select("revenues.description,till,date,value,t.name,type_id")
    @sum_revenues = Revenue.all.map {|revenue| revenue.sumvalues}.inject(:+)
    @sum_expenses = Expense.all.map {|expense| expense.sumvalues}.inject(:+)
    @total = @sum_expenses - @sum_revenues
  end

end

