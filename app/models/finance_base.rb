class FinanceBase < ActiveRecord::Base

  establish_connection(
{ :adapter  => "mysql2",
  :host     => "localhost",
  :username => Diaspora::Application.config.database_configuration[Rails.env]["username"],
  :password => Diaspora::Application.config.database_configuration[Rails.env]["password"],
  :database => "finances" }
  )
  
  self.abstract_class = true
  
end

