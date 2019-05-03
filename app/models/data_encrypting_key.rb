class DataEncryptingKey < ActiveRecord::Base

  attr_encrypted :key, key: :key_encrypting_key

  has_many :encrypted_strings, dependent: :destroy

  validates :key, presence: true

  STATUSES = {queued: 'Key rotation has been queued', working: 'Key rotation is in progress', complete: 'No key rotation queued or in progress'}

  def self.primary
    find_by(primary: true)
  end

  def self.generate!(attrs={})
    create!(attrs.merge(key: AES.key))
  end

  def key_encrypting_key
    ENV['KEY_ENCRYPTING_KEY']
  end
end

