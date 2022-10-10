require_relative "room"

class Hotel

    attr_reader :rooms

  def initialize(name, rooms)
    @name = name
    @rooms = Hash.new
    rooms.each do |key, val|
        @rooms[key] = Room.new(val)
    end
  end
  
  def name
    copycat = @name.dup.split(" ")
    fancied = copycat.map! {|word| word.capitalize}
    fancied.join(" ")
  end

  def room_exists?(name)
    if @rooms.include?(name)
        return true
    else
        return false
    end
  end

  def check_in(person, room_name)
    if room_exists?(room_name)
        if @rooms[room_name].add_occupant(person) == true
            p 'check in successful'
        else
            p 'sorry, room is full'
        end
    else
        p 'sorry, room does not exist'
    end
  end

  def has_vacancy?
    if @rooms.values.any? {|room| room.full? == false}
        return true
    else
        return false
    end
  end

  def list_rooms
    @rooms.each do |key, val|
        puts key + val.available_space.to_s
    end
  end

end
