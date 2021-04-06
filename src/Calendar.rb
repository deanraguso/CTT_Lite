require_relative 'Schedule.rb'

DAY = {1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 
    4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday', 7 => 'Sunday'}

class Calendar
    def initialize(db, timeframe = 7)
        @mode = "balanced"
        @schedule = Schedule.new(db, timeframe) #Array of Array of Tasks
    end

    def create_schedule(db, timeframe)
        @schedule.form_schedule(db, timeframe)
    end

    def print_schedule
        @schedule.print_plan
    end
end