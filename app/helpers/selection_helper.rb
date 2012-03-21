class ApplicationController < ActionController::Base

  def set_git_header
   headers['X-Git-Update'] = AppConfig[:git_update] if AppConfig[:git_update].present?
  end
  
end
