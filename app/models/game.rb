class Game < ApplicationRecord

  before_create :blank_grid

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
        throw "State must have 9 cells"
      end
    else
      throw "State must be an array"
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

  def result
    s = self.state

    # rows
    [0,3,6].each do |r|
      if !s[r].blank? && (s[r] == s[r+1] && s[r] == s[r+2])
        return s[r]
      end
    end

    # columns
    [0,1,2].each do |c|
      if !s[c].blank? && (s[c] == s[c+3] && s[c] == s[c+6])
        return s[c]
      end
    end

    # diagonals
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
end