# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_authenticated
    redirect_to sign_in_path, notice: 'サインインしてください'
  end
end
