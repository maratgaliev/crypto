class BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def api_response(data)
    render json: data
  end

  def error_response(errors, status=:unprocessable_entity)
    render json: {errors: errors}, status: status
  end

  def run_command(command, params)
    command.run(params) do |m|
      m.success {|object| api_response(object) }
      m.failure {|errors| error_response(errors) }
    end
  end
end
