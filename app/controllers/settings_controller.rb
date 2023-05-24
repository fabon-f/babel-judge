# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :require_login

  def show; end

  def update
    if current_user.update(profile_params)
      redirect_to settings_url, notice: '更新しました。'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def profile_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
