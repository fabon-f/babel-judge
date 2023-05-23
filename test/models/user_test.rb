# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validation on username field' do
    assert User.new(username: 'foobar!').invalid?
  end

  test 'validation on password field' do
    assert User.new(username: 'foo', password: 'fo0barbaZ!').invalid?
    assert User.new(username: 'foo', password: 'fo0barbaZ!', password_confirmation: 'foobarbaz!').invalid?
  end
end
