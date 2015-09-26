module Destiny
  class Character
    attr_reader \
      :id,
      :light_level,
      :grimoire_score,
      :level

    def initialize(data, definitions = nil)
      load_from_data(data, definitions)
    end

    private
      def load_from_data(data, definitions)
        base = data[:character_base]
        @id = base[:character_id]
        @light_level = base[:power_level]
        @grimoire_score = base[:grimoire_score]
        @level = data[:level_progression][:level]
        @race = get_definition(base[:race_hash], :races, definitions)
        @gender = get_definition(base[:gender_hash], :genders, definitions)
        @klass = get_definition(base[:class_hash], :classes, definitions)
      end

      def get_definition(id, type, definitions)
        return nil unless definitions
        return nil unless (_type = definitions[type])
        return nil unless (_hash = _type[:"#{id}"])
        _hash
      end
  end
end
