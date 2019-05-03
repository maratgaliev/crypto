module EncryptedStrings
  class DestroyCommand < BaseCommand
    step :authorize
    step :destroy

    def authorize(token:)
      encrypted_string = EncryptedString.find_by(token: token)
      if encrypted_string
        Success(encrypted_string)
      else
        Failure(error(I18n.t('errors.encrypted_strings.not_found', token: token)))
      end
    end

    def destroy(encrypted_string)
      encrypted_string.destroy!
      Success(:deleted)
    end
  end
end
