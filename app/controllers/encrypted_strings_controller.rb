class EncryptedStringsController < BaseController
  def index
    EncryptedStrings::Query.index_query(params) do |q|
      q.success {|encrypted_strings| api_response(encrypted_strings) }
      q.failure {|errors| error_response(errors) }
    end
  end

  def create
    run_command(EncryptedStrings::CreateCommand, params: encrypted_string_params)
  end

  def show
    EncryptedStrings::ShowCommand.run(token: params[:token]) do |m|
      m.success {|data| api_response(data) }
      m.failure {|errors| error_response(errors, :not_found) }
    end
  end

  def destroy
    EncryptedStrings::DestroyCommand.run(token: params[:token]) do |m|
      m.success { head :no_content }
      m.failure {|errors| error_response(errors, :not_found) }
    end
  end

  private

  def encrypted_string_params
    params.require(:encrypted_string).permit(:value)
  end
end
