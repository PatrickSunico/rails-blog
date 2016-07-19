class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


    private
    def confirm_logged_in
      # unless user id does not exist anymore in the session cookie,
      # or session[:user_id] == false
      # unless executes code if it's false
      unless session[:user_id] # = unless = false or 0
        # Then flash notice please login and do a redirect to the access/login page
        flash[:notice] = "Please log in."
        redirect_to(:controller => 'access', :action => 'login')
        return false # halts the before action
        # else return true, then carry on towards the index page
      end
    end
end
