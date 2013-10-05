module PageLayout
  class Model
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    
    def initialize
      @_fields = {}
    end
    
    def attributes=(hash)
      @_fields.merge! hash.symbolize_keys
    end
    def attributes
      @_fields
    end
    
    def method_missing(m, *args, &block)  
      if @_fields.has_key? m.to_sym
        @_fields[m.to_sym]
      end
    end  
    def persisted?
      false
    end
    def save
      true
    end
    
  end
end