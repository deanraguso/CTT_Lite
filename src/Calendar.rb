require_relative 'Schedule.rb'

class Calendar
    def initialize(db, user_id)
        @user_id = user_id
        @mode = "balanced"
        @timeframe = 7

        # Remakes database, filtering out any entries that don't belong to user.
        @db = []
        filter_db(db)

        @schedule = Schedule.new(@db, @timeframe) #Array of Array of Tasks
    end

    # Sets the calendar options
    def options
        prompt = TTY::Prompt.new
        @timeframe = prompt.slider("Timeline in days: ", min: 1, max: 14, step: 1)
        @mode = prompt.select("CTT-Lite", [
            # Balanced: Get's all tasks done within timeframe.
            { name: "Balanced Schedule", value: "balanced" },
            # Hard: Get's all tasks done within timeframe, get's tasks done ASAP.
            { name: "Hard Deadline", value: "hard" },
            # Soft: Get's all tasks done, pushed timeframe out for working hours.
            { name: "Soft Deadline", value: "soft" }
        ])
        system 'clear'
        prompt.ok("Calendar Options have been changed!")
    end

    def filter_db(db)
        @db = db.select { |t| t.user_id == @user_id}
    end

    def create_schedule
        @schedule.soft_schedule(@db, @timeframe)
    end

    def press_enter_to_continue
        print "Press [ENTER] to continue!"
        gets
        system "clear"
    end

    def print_summary
        puts "Calendar Mode:\t\t#{@mode.upcase}"
        puts "Timeframe:\t\t#{@timeframe}"
        puts "Number of Tasks:\t#{@db.length}"
    end

    def print_schedule
        system 'clear'
        puts "Printing #{@mode} schedule:"
        @schedule.print_plan
        press_enter_to_continue
        system 'clear'
        print_summary
        press_enter_to_continue

    end
end