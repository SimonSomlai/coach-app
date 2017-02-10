# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :find_user, except: [:index, :create, :new]
  before_filter :logged_in_user?, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @url = users_path
    @user = Trainer.new(trainer_user_params)
    if @user.save
      flash[:success] = "Welkom #{@user.name}!"
      login @user
      redirect_to dashboard_path
    else
      render :new
      flash[:danger] = 'An error occured'
    end
  end

  def edit
    @url = user_path(@user)
  end

  def update
    @user.trainer_id == nil ? (user_params = trainer_user_params) : (user_params = client_user_params)
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}'s profiel bewerkt!"
      @url = user_path(@user)
      render :edit
    else
      render :edit
      flash[:danger] = 'Er was een error.'
    end
  end

  def destroy
    name = @user.name
    @user.destroy
    redirect_to users_path
    flash[:success] = "#{name} verwijderd!"
  end

  private

  def trainer_user_params
    params.require(:trainer).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def client_user_params
    params.require(:client).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
