class FinancesController < ApplicationController
  before_filter :authenticate_user!
end
