class Game < ApplicationRecord

  before_create :blank_grid

  after_save :broadcast_update

  # Return the state as an array
  def state
    self[:state].split(",")
  end

  # Save a new state array as a comma-separated string
  def state=(new_state)
    if new_state.is_a?(Array)
      if new_state.count == 9
        self[:state] = new_state.join(",")
      else
        throw "State must have 9 cells -- #{new_state.join(",")}"
      end
    else
      throw "State must be an array"
    end
  end

  # Return a list of array indices with empty cells
  def empty_spaces
    empty = []
    self.state.each_with_index do |e,i|
      empty.push(i) if e.blank?
    end
    return empty
  end

  def cpu_score
    case self.result
    when "O"
      return 10 - xes
    when "X"
      return -10 + os
    else
      #draw or incomplete
      return 0
    end
  end

  # Returns which player's turn it is
  def turn
    if xes > os
      return "O"
    elsif os == xes
      return "X"
    end
  end

  # Get the result of the game, or false if it is still ongoing
  def result
    s = self.state

    # Check rows
    [0,3,6].each do |r|
      if !s[r].blank? && (s[r] == s[r+1] && s[r] == s[r+2])
        return s[r]
      end
    end

    # Check columns
    [0,1,2].each do |c|
      if !s[c].blank? && (s[c] == s[c+3] && s[c] == s[c+6])
        return s[c]
      end
    end

    # Check diagonals
    if !s[0].blank? && (s[0] == s[4] && s[0] == s[8])
      return s[0]
    end
    if !s[2].blank? && (s[2] == s[4] && s[2] == s[6])
      return s[2]
    end

    # no winner, all spaces used
    if s.select{|e| !e.blank? }.count == 9
      return "draw"
    end

    return false
  end

  # Make a move
  def play(index,player=nil)
    r = self.result
    unless r
      index = index.to_i

      raise "Invalid player" unless %w(X O).include?(player)
      raise "Not your turn" unless self.turn == player

      s = self.state
      if s[index].blank?
        s[index] = player
        self.state = s
      else
        raise "Space taken"
      end
    else
      raise "Game over -- #{r}"
    end
  end

  # Make a move and save
  def play!(space,player=nil)
    self.play(space,player)
    self.save
  end

  def xes
    self.state.select{|e| e == "X" }.count
  end

  def os
    self.state.select{|e| e == "O" }.count
  end

  private
  def blank_grid
    self.state = [" "," "," "," "," "," "," "," "," "]
  end

  def broadcast_update
    ActionCable.server.broadcast(self,self)
  end
end
