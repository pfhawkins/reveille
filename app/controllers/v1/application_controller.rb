class V1::ApplicationController < ActionController::Base
  include Reveille::Event::Mixins::Controller

  respond_to :json

  set_current_tenant_through_filter
  before_action :set_tenant

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError do |e|
    render nothing: true, status: :not_found
  end

  # rescue_from StateMachine::Invalid

  def after_sign_in_path_for(resource_or_scope)
    dashboard_url
  end

  def current_account
    current_actor.try(:account)
  end
  helper_method :current_account

  protected

  def set_tenant
    set_current_tenant current_actor.try(:account)
  end

  def default_json
    request.format = :json if params[:format].nil?
  end

  def auth!
    unless params[:auth_token] && ( user_signed_in? || service_signed_in? )
      # render json: {}, status: 401
      render nothing: true, status: 401
    end
  end
  
end
