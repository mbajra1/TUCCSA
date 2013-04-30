module ApplicationHelper
  def get_progress
    progress = 0
    if !(current_user.cs_application.nil?)
      progress = current_user.cs_application.progress
    end
    progress
  end

end
