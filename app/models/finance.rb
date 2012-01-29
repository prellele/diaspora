class FinancesBase < ActiveRecord::Base

  establish_connection(
{ :adapter  => "mysql",
  :host     => "localhost",
  :username => Diaspora::Application.config.database_configuration[Rails.env]["username"],
  :password => Diaspora::Application.config.database_configuration[Rails.env]["password"],
  :database => "finances" }
  )

end
