class DataEncryptingKeysController < ApplicationController
  skip_before_action :verify_authenticity_token

  def rotate
    job_id = GeneratorWorker.perform_async
    render json: {job_id: job_id}
  end

  def status
    result = DataEncryptingKeys::StatusService.call(params[:job_id])
    render json: {message: result}
  end
end
