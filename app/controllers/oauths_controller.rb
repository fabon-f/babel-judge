# frozen_string_literal: true

class OauthsController < ApplicationController
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    prev_user = current_user
    @user = login_from(provider)

    if @user && prev_user && @user != prev_user
      auto_login(prev_user)
      redirect_to root_path, alert: "#{provider_name(provider)}アカウントが既に他のアカウントに連携されています。"
    elsif @user && prev_user && @user == prev_user
      redirect_to settings_path, notice: "#{provider_name(provider)}アカウントが既に連携されています。"
    elsif @user
      redirect_back_or_to root_path, notice: "#{provider_name(provider)}アカウントでログインしました。"
    elsif current_user
      # OAuth login failed, but already logged in by other method
      add_provider_to_user(provider)
      redirect_to settings_path, notice: "#{provider_name(provider)}アカウントを連携しました。"
    else
      create_new_user(provider)
    end
  rescue OAuth2::Error => e
    logger.error e.full_message(highlight: false)
    redirect_to sign_in_path, alert: "#{provider_name(provider)}アカウントの連携に失敗しました。"
  end

  private

  def provider_name(provider)
    { 'github' => 'GitHub' }[provider]
  end

  def create_new_user(provider)
    @user = create_from(provider) do |user|
      user.username = 20.times.map { rand(36).to_s(36) }.join
      user.oauth_auth!
    end
    reset_session
    auto_login(@user)
    redirect_back_or_to user_path(@user), notice: "#{provider_name(provider)}で登録・ログインしました。"
  rescue StandardError => e
    logger.error e.full_message(highlight: false)
    redirect_to root_path, alert: "#{provider_name(provider)}アカウントでの登録に失敗しました。"
  end
end
