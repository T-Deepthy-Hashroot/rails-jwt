class HomeController < ApplicationController
  def new
    render html: "Email is confirmed and account is activated!"
  end
end
