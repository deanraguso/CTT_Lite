require_relative 'Schedule.rb'
require 'ascii_charts'

class Calendar
    def initialize(db, user_id)
        @user_id = user_id
        @mode = "soft"
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
            # Hard: Get's all tasks done within timeframe, get's tasks done ASAP.
            { name: "Hard Deadline", value: "hard" },
            # Soft: Get's all tasks done, pushed timeframe out for working hours.
            { name: "Soft Deadline", value: "soft" }
        ])
        create_schedule
        system 'clear'
        prompt.ok("Calendar Options have been changed!")
    end

    def filter_db(db)
        @db = db.select { |t| t.user_id == @user_id}
    end

    def create_schedule
        case @mode
        when "hard"
            @schedule.hard_schedule(@db, @timeframe)
        when "soft"
            @schedule.soft_schedule(@db, @timeframe)
        else
            puts "Error: Should never get here!"
            exit
        end
    end

    def press_enter_to_continue
        print "Press [ENTER] to continue!"
        gets
        system "clear"
    end

    def print_summary
        puts "Calendar Mode:\t\t#{@mode.upcase}"
        puts "Timeframe:\t\t#{@timeframe}"
        print "Number of Tasks:\t#{@db.length}"
    end

    def print_graph
        data = @schedule.plan.each_with_index.map() { |day, index| 
            [index+1, day[:hours]]
        }
        # Space Graph Out
        data.unshift([0,0])
        
        puts AsciiCharts::Cartesian.new(data,
            :bar => true, :hide_zero => true).draw
    end

    def print_schedule
        system 'clear'
        puts "Printing #{@mode} schedule:"
        @schedule.print_plan
        press_enter_to_continue
        system 'clear'
        print_summary
        print_graph
        press_enter_to_continue
    end
end