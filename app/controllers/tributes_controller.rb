class TributesController < ApplicationController
	before_action :signed_in_user
  before_action :correct_user, only: [:destroy, :edit]

  def create
  	@tribute = current_user.tributes.build(tribute_params)
		if @tribute.save
    	flash[:success] = "Tribute Created."
			redirect_to @tribute
		else
      redirect_to root_path
		end
  end


  def show
  	@tribute = Tribute.find(params[:id])
  	@user = User.find(@tribute.user_id)
  end

  def edit
    @tribute = Tribute.find(params[:id])
  end

  def update
    @tribute = Tribute.find(params[:id])
    if @tribute.update_attributes(tribute_params)
      flash[:success] = "Tribute Updated."
      redirect_to @tribute
    else
      render 'edit'
    end
  end

  def destroy
    @tribute.destroy
    flash[:success] = "Tribute Destroyed."
    redirect_to request.referrer || root_url
  end

 private
 	def tribute_params
 		params.require(:tribute).permit(:name, :obituary, :dobirth, :dodeath, :image)
 	end

  def correct_user
    @tribute = current_user.tributes.find_by(id: params[:id])
    redirect_to root_url if @tribute.nil?
  end
end