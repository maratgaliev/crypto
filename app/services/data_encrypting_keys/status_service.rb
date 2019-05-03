module DataEncryptingKeys
  class StatusService
    DEFAULT_MESSAGE = 'Job ID not found'.freeze
    def self.call(job_id)
      status = Sidekiq::Status.status(job_id)
      DataEncryptingKey::STATUSES[status] || DEFAULT_MESSAGE
    end
  end
end
