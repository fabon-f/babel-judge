# frozen_string_literal: true

class UserSessionsController < ApplicationController
  def new
    redirect_to :root, notice: '既にログインしています。' if current_user
  end

  def create
    @user = login(params[:username], params[:password])

    if @user
      redirect_back_or_to :root, notice: 'ログインに成功しました。'
    else
      redirect_to :sign_in, alert: 'ログインに失敗しました。'
    end
  end

  def destroy
    logout
    redirect_to :root, notice: 'ログアウトしました。'
  end
end
