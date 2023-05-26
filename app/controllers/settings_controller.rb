# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :require_login

  def show
    @user = User.preload(:external_authentications).find(current_user.id)
  end

  def update
    param_updates = profile_params
    param_updates.compact_blank! if param_updates[:password].nil?
    if current_user.update(param_updates)
      redirect_to settings_url, notice: '更新しました。'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def profile_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
