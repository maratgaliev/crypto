class GeneratorWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  SIZE = 100.freeze

  def perform(*args)
    primary = DataEncryptingKey.primary
    if primary
      logger.info "GENERATING NEW KEY..."
      primary.update_column(:primary, false)
      data_encrypting_key = DataEncryptingKey.generate!(primary: true)
      # use batch update
      EncryptedString.find_each(batch_size: SIZE) do |str|
        decoded = str.value
        str.data_encrypting_key_id = data_encrypting_key.id
        str.value = decoded
        str.save
      end
      DataEncryptingKey.where(primary: false).delete_all
    end
  end
end
