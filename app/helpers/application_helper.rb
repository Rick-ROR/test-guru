module ApplicationHelper
  def get_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to author, repo, target: "_blank"
  end
  
  ALERT_CLASSES = { success: 'success', notice: 'info', alert: 'danger' }
  DEFAULT_ALERT = 'info'

  def bootstrap_alert(alert)
    css_class = ALERT_CLASSES[alert.to_sym] || DEFAULT_ALERT
    "alert alert-#{css_class}"
  end
end


