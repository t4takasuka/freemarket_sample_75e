class UsersController < ApplicationController
  before_action :move_to_index, except: :show

  def show
    @user = User.find(params[:id])
  end

  def logout
  end
  
  def mypage
  end

  private

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end
end
