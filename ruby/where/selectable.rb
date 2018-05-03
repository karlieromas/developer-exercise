module Selectable
  def where(hash)
    # def where(hash: Hash) : Array
    self.select do |item|
      hash.all? do |key, value|
        if value.kind_of?(Regexp)
          item[key].match(value)
        else
          item[key] == value
        end
      end
    end
  end
end

class Array
  include Selectable
end
