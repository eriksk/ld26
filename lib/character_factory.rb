module LD26
  class CharacterFactory
    def self.create(window, type)
      character = nil
      case type
      when :player
        character = Character.new(window.load_tiles("player", 16, 16))
          .add_behavior(PlayerMovementBehavior.new(window))
      end
      character
    end
  end
end
