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
      flash.now[:alert] = 'ログインに失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to :root, notice: 'ログアウトしました。'
  end
end
