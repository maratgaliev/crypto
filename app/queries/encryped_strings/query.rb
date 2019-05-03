module EncryptedStrings
  class Query
    include Dry::Transaction
    PER_PAGE = 100
    step :model_scope
    step :paginate

    def self.index_query(params={}, &block)
      new.call(params: params, &block)
    end

    def model_scope(params:)
      relation = EncryptedString.includes(:data_encrypting_key).all
      Success(relation: relation, params: params)
    end

    def paginate(relation:, params:)
      Success(relation.paginate(page: params[:page], per_page: PER_PAGE))
    end
  end
end
