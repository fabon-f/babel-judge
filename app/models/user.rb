# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :username, uniqueness: true, presence: true,
    format: { with: /\A[a-z0-9_]+\z/, message: 'には英数字・アンダースコアのみが使用できます' }
  validates :email, uniqueness: true, format: { with: /.+@.+/ }, allow_nil: true
  validates :password, length: { minimum: 8 }, confirmation: true, if: -> { changes[:password_hash] || password }
  validates :password_confirmation, presence: true, if: -> { !password.nil? }

  validates :email, presence: true, on: :password_auth
  validates :password, presence: true, on: :password_auth

  def to_param
    username
  end
end
