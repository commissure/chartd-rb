require 'chartd/chart'
require 'chartd/encoder'

class Chartd
  # helper method for directly encoding data for when the user wants to
  # generate the chart URL herself.
  def self.encode(*args)
    Encoder.encode(*args)
  end
end
