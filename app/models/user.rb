# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :username, uniqueness: true, presence: true,
    format: { with: /[a-z0-9_]+/, message: 'には英数字・アンダースコアのみが使用できます' }
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, confirmation: true,
    if: -> { new_record? || changes[:password_hash] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_hash] }

  def to_param
    username
  end
end
