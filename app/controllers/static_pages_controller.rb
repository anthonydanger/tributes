class StaticPagesController < ApplicationController
  def home
    @tribute = current_user.tributes.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end

  def privacy
  end
end
