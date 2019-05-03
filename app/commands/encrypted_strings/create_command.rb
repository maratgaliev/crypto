module EncryptedStrings
  class CreateCommand < BaseCommand
    step :persist

    def persist(params:)
      encrypted_string = EncryptedString.new(params)
      if encrypted_string.save
        Success(encrypted_string)
      else
        Failure(error(encrypted_string.errors.full_messages.to_sentence))
      end
    end
  end
end
