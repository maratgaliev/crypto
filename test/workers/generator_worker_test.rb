require 'test_helper'
require 'sidekiq/testing'

class GeneratorWorkerTest < Minitest::Test
  def setup
    Sidekiq::Testing.fake!
  end

  def check_jobs_size
    assert_equal 0, GeneratorWorker.jobs.size
    GeneratorWorker.perform_async(1, 2)
    assert_equal 1, GeneratorWorker.jobs.size
  end 
end
