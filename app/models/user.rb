# frozen_string_literal: true

class User < ApplicationRecord
  has_many :external_authentications, dependent: :destroy
  accepts_nested_attributes_for :external_authentications
  authenticates_with_sorcery!
  enum :primary_auth_method, { password: 0, oauth: 1 }, suffix: :auth

  validates :username, uniqueness: true, presence: true,
    format: { with: /\A[a-z0-9_]+\z/, message: 'には英数字・アンダースコアのみが使用できます' }
  validates :email, uniqueness: true, format: { with: /.+@.+/ }, allow_nil: true
  validates :password, length: { minimum: 8 }, confirmation: true, if: -> { changes[:password_hash] || password }
  validates :password_confirmation, presence: true, if: -> { !password.nil? }

  validates :email, presence: true, if: :password_auth?
  validates :password, presence: true, on: :password_auth_registration

  def to_param
    username
  end
end
