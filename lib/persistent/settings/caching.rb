module Persistent
  module Settings
    module Caching
      def cache_key_for(key)
        "settings/#{key}"
      end

      def write_to_cache(key, value)
        ::Rails.cache.write(cache_key_for(key), value)
      end

      def read_from_cache(key)
        ::Rails.cache.fetch(cache_key_for(key))
      end
    end
  end
end
