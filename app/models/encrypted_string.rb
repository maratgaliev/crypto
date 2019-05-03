class EncryptedString < ActiveRecord::Base
  belongs_to :data_encrypting_key

  attr_encrypted :value,
                 mode: :per_attribute_iv_and_salt,
                 key: :get_encrypted_key
  validates :token, presence: true, uniqueness: true
  validates :data_encrypting_key, presence: true
  validates :value, presence: true

  before_validation :set_token, :set_data_encrypting_key

  def get_encrypted_key
    assign_encrypting_key
    data_encrypting_key.encrypted_key
  end

  def encryption_key
    assign_encrypting_key
    data_encrypting_key.key
  end

  private

    def assign_encrypting_key
      self.data_encrypting_key ||= get_primary
    end

    def generate_key
      DataEncryptingKey.generate!(primary: true)
    end

    def get_primary
      primary = DataEncryptingKey.primary
      primary ? primary : generate_key
    end

    def set_token
      begin
        self.token = SecureRandom.hex
      end while EncryptedString.where(token: self.token).present?
    end

    def set_data_encrypting_key
      assign_encrypting_key
    end
end
