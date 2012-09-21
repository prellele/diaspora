module FinancesHelper

  def totalfinances
    Revenue.all.map {|revenue| revenue.sumvalues}.inject(:+) - Expense.all.map {|expense| expense.sumvalues}.inject(:+)
  end
  
  def onetime_revenues
    @onetime_revenues = Revenue.where('t.id in (?)', [1,3,4,5]).joins("left join `types` t ON t.id = type_id").select("revenues.description,revenues.date,revenues.value,t.name,type_id")
  end

end
