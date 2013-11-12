class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :record_action_log

  def record_action_log
    logging_params = params.select do |param|
      [:action, :target, :version].include? param
    end
    action_log = ActionLog.new
    action_log.action = logging_params[:action]
    action_log.target = logging_params[:target] || request.original_url
    action_log.version = logging_params[:version]
    action_log.ip = request.remote_ip
    action_log.referrer = request.referer
    action_log.save
  end
end
