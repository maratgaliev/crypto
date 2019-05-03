class BaseCommand
  include Dry::Transaction

  def self.run(params, &block)
    new.call(params, &block)
  end

  def error(error)
    {message: [error]}
  end
end
