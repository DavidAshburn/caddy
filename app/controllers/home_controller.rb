class HomeController < ApplicationController
  def index
  end

  def discbag
    @discbag = current_user.discs
  end
end
