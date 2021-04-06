require_relative 'Schedule.rb'

DAY = {1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 
    4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday', 7 => 'Sunday'}

class Calendar
    def initialize(db, timeframe = 7, user_id)
        @user_id = user_id
        @mode = "balanced"

        # Remakes database, filtering out any entries that don't belong to user.
        @db = []
        filter_db(db)

        @schedule = Schedule.new(@db, timeframe) #Array of Array of Tasks
    end

    def filter_db(db)
        @db = db.select { |t| t.user_id == @user_id}
    end

    def create_schedule(timeframe)
        @schedule.form_schedule(@db, timeframe)
    end

    def print_schedule
        @schedule.print_plan
    end
end