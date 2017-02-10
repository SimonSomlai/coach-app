class ApplicationController < ActionController::Base
  include SessionsHelper
  include StaticpagesHelper
  protect_from_forgery with: :exception
end
