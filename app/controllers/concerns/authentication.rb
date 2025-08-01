module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_path
    end

    def after_authentication_url(user: nil)
      return_to = session.delete(:return_to_after_authenticating)
      return return_to if return_to.present?

      case user.user_type
      when "business"
        business_dashboard_url
      when "volunteer"
        volunteer_dashboard_url
      when "organization"
        organization_dashboard_url
      else
        root_url
      end
    end

    def start_new_session_for(user, source: nil)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip, source:).tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end
