class HomeController < ApplicationController
  def index
  end

  def discbag
    @discbag = current_user.discs
  end

  def courses
    @courses = current_user.courses
  end
end
