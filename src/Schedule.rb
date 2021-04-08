DAY = {1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 
    4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday', 7 => 'Sunday'}

class Schedule
    def initialize(db, duration)
        @db = db
        @duration = duration

        #Array of objects that hold the total hours and list of tasks within each array element, (each element represents a day).
        @plan = [] 
        @plan[0] = Hash.new
        @plan[0][:hours] = 0.0
        @plan[0][:tasks] = []

        @rest_days = [6,0] 
        @working_hours = 8
        @safety_factor = 1.25

        # You must form a schedule when you instance it, changes can happen later.
        soft_schedule(@db, @duration)
    end

    # Must adjust so that increment keeps happening to skip over rest_days
    def soft_schedule(db, timeframe=7)
        index = 0
        @plan[index] = Hash.new
        @plan[index][:hours] = 0.0
        @plan[index][:tasks] = []

        db.each do |task|
            if ( task.time_required + @plan[index][:hours] ) * @safety_factor <= @working_hours

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

        if index > timeframe
            puts "Was unable to fit schedule into timeframe of #{time} days!"
        end

    end

    

    # Print the Schedule as it exists now. (Potentially unoptimised)
    def print_plan
        system 'clear'
        today = Date.today
        @plan.each_with_index do |day, index|
            print "#{index+1}. #{Date::DAYNAMES[(today+index).cwday%7]} with #{day[:hours]} hours of work:\n\t"
            day[:tasks].each do |task| 
                print "ID: #{task.id}\tTitle: #{task.title}\t (#{task.time_required} hours)\n\t"
            end
            puts
        end
    end
end