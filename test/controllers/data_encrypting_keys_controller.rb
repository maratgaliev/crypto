require 'test_helper'
require 'sidekiq/testing' 
Sidekiq::Testing.fake!
Sidekiq::Testing.inline!
Sidekiq::Testing.disable!

class DataEncryptingKeysControllerTest < ActionController::TestCase
  def setup
    @encrypted_string = EncryptedString.create!(value: 'my string')
  end

  test 'POST #rotate start job and return job_id' do
    post :rotate
    assert_response :success
    json = JSON.parse(response.body)
    assert json['job_id']
  end

  test 'GET #status for incorrect job_id' do
    get :status, job_id: 'test'
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 'Job ID not found', json['message']
  end
end
