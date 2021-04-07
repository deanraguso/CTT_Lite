class Schedule
    def initialize(db, duration)
        @db = db
        @duration = duration

        #Array of objects that hold the total hours and list of tasks
        @plan = [] 
        @plan[0] = Hash.new
        @plan[0][:hours] = 0.0
        @plan[0][:tasks] = []

        @total_work_hours = get_work_hours
        @rest_days = [6,0] 
        @working_hours = 8
        @safety_factor = 1.25

        # You must form a schedule when you instance it, changes can happen later.
        form_schedule(@db, @duration)
    end

    def get_work_hours
        total_hours = 0
        @db.each do |task| 
            total_hours += task.time_required
        end
        return total_hours
    end

    def sufficient_time? (timeframe)
        return timeframe*@working_hours >= @working_hours
    end

    # Must adjust so that increment keeps happening to skip over rest_days
    def form_schedule(db, timeframe=7)
        index = 0
        @plan[index] = Hash.new
        @plan[index][:hours] = 0.0
        @plan[index][:tasks] = []

        db.each do |task|
            if ( task.time_required.to_f + @plan[index][:hours] ) * @safety_factor <= @working_hours

                # If the plan fits on the current day
                @plan[index][:hours] += task.time_required
                @plan[index][:tasks] << task

            else 
                #If the plan didn't fit, go to next day
                index += 1 #Adjust this to account for weekends later

                @plan[index] = Hash.new
                @plan[index][:hours] = 0.0
                @plan[index][:tasks] = []
                
                @plan[index][:hours] += task.time_required
                @plan[index][:tasks] << task
            end
        end
    end

    def print_plan
        system 'clear'
        @plan.each_with_index do |day, index|
            print "Day #{index+1} with #{day[:hours]} hours of work:\n\t"
            day[:tasks].each {|task| print "#{task.id}\t"}
            puts
        end
    end
end