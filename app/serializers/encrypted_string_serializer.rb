class EncryptedStringSerializer < ActiveModel::Serializer
  attributes :value, :token
end