class HomeController < ApplicationController
  before_action :authorize_request
  def new
    render html: "Helllo"
  end

  def show
    render html: "Email is confirmed and account is activated!"
  end
end
