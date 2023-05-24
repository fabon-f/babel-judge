# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    assert User.new(username: 'foobar').valid?
  end

  test 'validation on username field' do
    assert User.new(username: 'foobar!').invalid?
  end

  test 'validation on password field' do
    assert User.new(username: 'foo', password: 'fo0barbaZ!').invalid?
    assert User.new(username: 'foo', password: 'fo0barbaZ!', password_confirmation: 'incorrect').invalid?
  end

  test 'validation on password authentication' do
    assert User.new(username: 'foobar', email: 'a@example.com').invalid?(:password_auth)
  end
end
