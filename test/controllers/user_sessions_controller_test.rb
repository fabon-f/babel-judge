# frozen_string_literal: true

require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  test 'Login page' do
    get sign_in_path
    assert_response :success
  end

  test 'Login' do
    post sign_in_url, params: { username: 'test1', password: 'pass_w0rD!' }
    assert_redirected_to root_path
  end

  test 'Login with incorrect password' do
    post sign_in_url, params: { username: 'test1', password: 'incorrect' }
    assert_redirected_to sign_in_path
  end

  test 'Logout' do
    post sign_in_url, params: { username: 'test1', password: 'pass_w0rD!' }

    get sign_out_url
    assert_redirected_to root_path
  end
end
