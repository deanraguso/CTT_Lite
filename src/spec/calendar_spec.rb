require 'Schedule.rb'

DAY = {1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 
    => 4 'Thursday', 5 => 'Friday', 6 => 'Saturday', 7 => 'Sunday'}

class Calendar
    def initialize
        @mode = "balanced"

        @schedule = Schedule.new(7) #Array of Array of Tasks
        @schedule.print_schedule
    end

    



end