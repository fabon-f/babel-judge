# frozen_string_literal: true

class OauthsController < ApplicationController
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    provider_name = { 'github' => 'GitHub' }[provider]
    @user = login_from(provider)

    if @user
      redirect_to root_path, notice: "#{provider_name}アカウントでログインしました。"
    else
      begin
        @user = create_from(provider) do |user|
          user.username = 20.times.map { rand(36).to_s(36) }.join
        end
        reset_session
        auto_login(@user)
        redirect_to user_path(@user), notice: "#{provider_name}で登録・ログインしました。"
      rescue StandardError => e
        logger.error e.full_message(highlight: false)
        redirect_to root_path, alert: "#{provider_name}アカウントでの登録に失敗しました。"
      end
    end
  end
end
