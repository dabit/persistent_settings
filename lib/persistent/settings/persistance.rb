module Persistent
  module Settings
    module Persistance
      def load_from_persistance!
        self.all.each do |setting|
          self.send("#{setting.var}=", setting.value)
        end
      end

      def load_from_persistance
        load_from_persistance! if ready?
      end

      def persist(getter, value)
        setting = self.where(:var => getter).last
        if setting
          setting.update_attribute(:value, value)
        else
          self.create(:var => getter, :value => value)
        end
      end

      def read_from_persistance(key)
        self.find_by_var(key).value
      end

    end
  end
end
