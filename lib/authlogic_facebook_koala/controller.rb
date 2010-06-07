require 'ostruct'
module AuthlogicFacebookKoala
  module Controller
    
    def self.included(controller)
      controller.send(:helper_method, :facebook_user?, :facebook_user, :facebook_session?, :facebook_session)
    end
  
    def facebook_user?
      !!facebook_user
    end
  
    def facebook_user
      current_user && current_user.facebook_user
    end
  
    def facebook_session?
      !!facebook_session
    end
    
    protected
    
    def facebook_session
      current_user && current_user.facebook_session
    end

    def facebook_graph
      current_user && current_user.facebook_graph
    end
    
    def create_facebook_session
      if cookies.has_key?("fbs_#{facebook_params.app_id}")
        oauth = Koala::Facebook::OAuth.new(facebook_params.app_id, facebook_params.secret_key)
        return OpenStruct.new( oauth.get_user_from_cookie(cookies) )
      else nil
      end
    end
      
    private
    
    def facebook_params
      AuthlogicFacebookKoala::CONFIG
    end
    
  end
end