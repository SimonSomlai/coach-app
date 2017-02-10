class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if logged_in?
    # Only used for template rendering
  end

  def create
    # When session form is send to sessions#create, find the email of the user in the nested hash.
    user = User.find_by(email: params[:session][:email].downcase)
    # If the email matches one in the db and the password matches
    if user && user.authenticate(params[:session][:password])
      # create session in the browser
      login user
      # if remember is true, create permanent remember_token cookie in the browser & sets remember_digest for user
      # else remove the cookies & digest
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      user.type == "Trainer" ? (redirect_to dashboard_path) : (redirect_to client_dashboard_path)
      flash[:success] = "Welkom terug #{user.name}!"
    else
      flash.now[:danger] = 'Fout Email of Wachtwoord'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to login_path
  end
end
