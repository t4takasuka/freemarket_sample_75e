class UsersController < ApplicationController
  before_action :move_to_index, except: :show

  def show
    @user = User.find(params[:id])
  end

  def logout
  end
  
  def mypage
    user = User.find(current_user.id)
    @profile = user.profile
  end

  def update
    user = User.find(current_user.id)
    @profile = user.profile
    if @profile.update(profile_params)
      redirect_to users_mypage_users_path, notice: 'アバター画像を更新しました'
    else
      render :mypage
    end
  end

  private

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end
end




