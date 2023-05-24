# frozen_string_literal: true

require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    post sign_in_url, params: { username: 'test1', password: 'pass_w0rD!' }
  end

  test 'get settings page' do
    get settings_url
    assert_response :success
  end
end
