class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = User.find(current_user.id)
      @tribute = current_user.tributes.build if signed_in?
      @tributes = current_user.tributes.paginate(page: params[:page])
    end
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
