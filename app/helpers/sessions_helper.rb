module SessionsHelper
 # ----------------------- STANDARD LOGIN ----------------------------------------------
 # Create an encrypted cookie in the browser of the users' id that corresponds to
 # the matching user using password & email combination in the login form
 def login(user)
  session[:user_id] = user.id
 end

 # Delete browser session for user_id and set current_user variable to nil
 def logout
  name = current_user.name
  forget(current_user)
  session.delete(:user_id)
  @current_user = nil
  flash[:success] = "Tot Binnenkort #{name}!"
 end

 def current_user
  # If there's a session called user_id in the browser, set it to user_id
  if (user_id = session[:user_id])
   # See if there's a current user (object) variable matching a user_id session in the browser. If there is one, keep it.
   # else, set the variable to that session.
   @current_user ||= User.find_by(id: user_id)
  # If there's a cookie called user_id in the browser, set it to user_id
  elsif (user_id = cookies.signed[:user_id])
   user = User.find_by(id: user_id)
   if user && user.authenticated?(cookies.signed[:remember_token])
    login user
    @current_user = user
   end
  end
 end

 # Check if the current_user variable has been made.
 def logged_in?
  !current_user.nil?
 end

 # ----------------------- PERMANENT LOGIN ----------------------------------------------
 def remember(user)
  # Call remember method on the user object
  user.remember
  # Sets a permanent (20y), encrypted cookie called user_id which corresponds to the user.id in the browser
  cookies.permanent.signed[:user_id] = user.id
  # Sets a permanent (20y) cookie called remember_token which corresponds to the user.remember_token (set when we called user.remember) in the browser
  cookies.permanent.signed[:remember_token] = user.remember_token
 end

 def forget(user)
  # Remove remember_digest from db for that user
  user.forget
  # Delete the cookies from the browser
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
 end

 # ----------------------- AUTHORIZATION ----------------------------------------------

 # Is this a logged in user?
 def logged_in_user?
  unless logged_in?
   # store location for logged out user (friendly redirect)
   store_location
   flash[:danger] = 'Je bent niet ingelogd'
   redirect_to login_path
  end
 end

 # comparison method for correct user, to be used in views | returns true or false
 def current_user?(user)
  user == current_user
 end

 # before_filter for authorization in controller
 def is_correct_user?
  # Set user variable from params passed through link
  @user = User.find(params[:id])
  # Comparison
  unless current_user?(@user)
   redirect_to dashboard_path
   flash[:danger] = 'Dit is niet jouw profiel'
  end
 end

 # before_filter for authorization in controller
 def is_admin?
  unless current_user.admin? && @exercise.type
   flash[:danger] = 'Enkel admins kunnen dit doen'
   redirect_to dashboard_path
  end
 end

 def current_user_is_trainer?
  current_user.type == 'Trainer' ? true : false
end

 # comparison method for admin user, to be used in views | returns true or false
 def current_user_is_admin?
  current_user.admin?
 end

 def current_user_is_client?
   current_user.type == 'Client' ? true : false
 end

 def limit_client_access
   if current_user_is_client?
     redirect_to client_dashboard_path
     flash[:danger] = "Enkel trainers kunnen dat doen"
  end
end

 # ----------------------- REDIRECTION & STORED LOCATION----------------------------------------------

 # Friendly redirect when logging in after failed url attempt
 def redirect_back_or(default)
  redirect_to(session[:forwarding_url] || default)
  session.delete(:forwarding_url)
 end

 # Stores location of previous get request in the browser
 def store_location
  session[:forwarding_url] = request.url if request.get?
 end
end
