# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge({ primary_auth_method: :password }))

    if @user.save(context: :password_auth_registration)
      auto_login(@user)
      redirect_to user_url(@user), notice: 'ユーザー登録に成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    @user.destroy

    redirect_to root_url, notice: 'アカウントを削除しました。'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by!(username: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
