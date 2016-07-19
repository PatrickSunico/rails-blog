class AccessController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  def index
    # display text & links
  end

  def login
    # displays login form
    # On user submit redirect to attempt_login to check user authentication
  end

  def attempt_login
    # Check if the params[:username] and params[:password] hash contains a value
    if params[:username].present? && params[:password].present?
      # Next find the user that matches with the submitted user from the params[:username] hash, then store that into our found_user variable
      found_user = AdminUser.where(:username => params[:username]).first
      if found_user
        # use the found_user variable as reference to where we matched the user from our db and from the params hash.

        # authenticate the password from the params[:password] hash
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    # if authorized user is correct redirect them to the page
    if authorized_user
        # mark user as logged in
        # store the table row ID of the user's ID
        session[:user_id] = authorized_user.id
        # store user's Username in the session file.
        session[:username] = authorized_user.username

        flash[:notice] = "You are now logged in"
        redirect_to(:action => "index")
    else
      # unless params[:username] && params[:password] = false
      # do flash notice Please enter a username or Password
      unless params[:username].present? && params[:password].present?
        flash[:notice] = "Please Enter a Username or Password"
        redirect_to(:action => 'login')
      else
        # Catch all error handling do flash notice invalid credentials
        flash[:notice] = "Invalid username/password combination"
        redirect_to(:action => 'login')
      end

    end
  end

  def logout
    # Marks a user as logout
    # If user logs out flush out all credentials that is stored in this session/cookie file.
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have logged out"
    redirect_to(:action => "login")
  end
end
