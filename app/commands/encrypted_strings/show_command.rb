module EncryptedStrings
  class ShowCommand < BaseCommand
    step :get
    def get(token:)
      encrypted_string = EncryptedString.find_by(token: token)
      encrypted_string ? Success(encrypted_string) : Failure(error(I18n.t('errors.encrypted_strings.not_found', token: token)))
    end
  end
end
