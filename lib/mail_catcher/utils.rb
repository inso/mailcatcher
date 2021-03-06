module MailCatcher
  module Utils
    def self.symbolize_hash_keys(obj)
      if obj.is_a? Hash
        obj.inject({}) do |memo, (k, v)|
          memo[k.to_sym] = symbolize_hash_keys(v)
          memo
        end
      elsif obj.is_a? Array
        obj.inject([]) do |memo, v|
          memo << symbolize_hash_keys(v)
          memo
        end
      else
        obj
      end
    end

    def self.recursive_walk(obj, &block)
      if obj.is_a? Hash
        obj.inject({}) do |memo, (k, v)|
          memo[k] = recursive_walk(v, &block)
          memo
        end
      elsif obj.is_a? Array
        obj.inject([]) do |memo, v|
          memo << recursive_walk(v, &block)
          memo
        end
      elsif block_given?
        block.call(obj)
      else
        obj
      end
    end
  end
end
