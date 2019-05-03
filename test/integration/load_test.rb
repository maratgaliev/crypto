require 'test_helper'
require 'sidekiq/testing'

class LoadTest < ActionDispatch::IntegrationTest
  def setup
    Sidekiq::Testing.disable!
    EncryptedString.delete_all
    Sidekiq::Worker.clear_all
  end

  test "create" do
    create_list :encrypted_string, 3000
    jid = GeneratorWorker.perform_async
    GeneratorWorker.drain
    begin
      get job_status_path, { job_id: jid }
      json = JSON.parse(response.body)
      msg = json["message"]
    end while msg != 'No key rotation queued or in progress'
  end
end