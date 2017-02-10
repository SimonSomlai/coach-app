# frozen_string_literal: true
class ClientsController < ApplicationController
 require 'will_paginate/array'
 before_action :find_client, except: [:index, :create, :new]
 before_action :set_clients, only: [:index, :create, :update, :edit]
 before_action :limit_client_access, except: [:edit, :update]
 before_filter :logged_in_user?

 def index
  @action = 'Nieuwe'
  @client = current_user.clients.build
 end

 def show
  @trainings = ClientTraining.where(client_id: @client.id)
  @training = ClientTraining.new
 end

 def create
  @client = current_user.clients.build(user_params)
  if @client.save
   flash[:success] = "#{@client.name} aangemaakt"
   redirect_to user_clients_path(current_user)
  else
   @action = 'Bewerk'
   render :index
   flash[:danger] = 'An error occured'
  end
 end

 def edit
  @action = 'Bewerk'
 end

 def update
  if @client.update_attributes(user_params)
   flash[:success] = "#{@client.name}'s profiel bewerkt!"
   redirect_to user_clients_path(current_user)
  else
   @action = 'Bewerk'
   render :edit
   flash[:danger] = 'Er was een error.'
  end
 end

 def destroy
  name = @client.name
  @client.destroy
  redirect_to user_clients_path(current_user)
  flash[:success] = "#{name} verwijderd!"
 end

 private

 def user_params
  params.require(:client).permit(:name, :email, :password, :password_confirmation, :image, :address, :phone, :information)
 end

 def find_client
  @client = Client.find(params[:id])
 end

 def set_clients
  @clients = current_user.clients.order('created_at DESC').paginate(page: params[:page], per_page: 9)
 end
end
