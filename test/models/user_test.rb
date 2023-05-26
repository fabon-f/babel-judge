# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    assert User.new(username: 'foobar', primary_auth_method: :oauth).valid?
    assert User.new(username: 'foobar', email: 'a@example.com').valid?
  end

  test 'validation on username field' do
    assert User.new(username: 'foobar!', email: 'a@example.com').invalid?
  end

  test 'validation on password field' do
    assert User.new(username: 'foo', email: 'a@example.com', password: 'fo0barbaZ!').invalid?
    assert User.new(
      username: 'foo', email: 'a@example.com', password: 'fo0barbaZ!', password_confirmation: 'incorrect'
    ).invalid?
  end

  test 'validation on password registration' do
    assert User.new(username: 'foobar', email: 'a@example.com').invalid?(:password_auth_registration)
  end
end
