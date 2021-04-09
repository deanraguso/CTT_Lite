class Schedule
    attr_reader :plan, :rest_days
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
        @safety_factor = 1

        # You must form a schedule when you instance it, changes can happen later.
        soft_schedule(@db, @duration)
    end

    
    def soft_schedule(db, timeframe=7)
        index = 0
        @plan[index] = Hash.new
        @plan[index][:hours] = 0.0
        @plan[index][:tasks] = []

        today = Date.today

        db.each do |task|
            # Skip Weekends
            while (@rest_days.include?((today+index).cwday%7))
                index += 1
                @plan[index] = Hash.new
                @plan[index][:hours] = 0.0
                @plan[index][:tasks] = []
            end

            if ( task.time_required + @plan[index][:hours] ) * @safety_factor <= @working_hours

                # If the plan fits on the current day
                @plan[index][:hours] += task.time_required
                @plan[index][:tasks] << task

            else 
                #If the plan didn't fit, go to next day
                index += 1 

                # Instance new day, even if it's saturday.
                @plan[index] = Hash.new
                @plan[index][:hours] = 0.0
                @plan[index][:tasks] = []

                # Skip Weekends
                while (@rest_days.include?((today+index).cwday%7))
                    index += 1

                    # It would still instance saturday, even if not used, MUST!
                    @plan[index] = Hash.new
                    @plan[index][:hours] = 0.0
                    @plan[index][:tasks] = []
                end
                
                @plan[index][:hours] += task.time_required
                @plan[index][:tasks] << task
            end
        end

        if index > timeframe
            puts "Was unable to fit schedule into timeframe of #{timeframe} days!"
        end
    end

    
    def hard_schedule(db, timeframe=7)
        index = 0

        # Reset plan, make new.
        @plan = []

        @plan[index] = Hash.new
        @plan[index][:hours] = 0.0
        @plan[index][:tasks] = []

        today = Date.today

        db.each do |task|
            if ( task.time_required + @plan[index][:hours] ) * @safety_factor <= @working_hours

                # If the plan fits on the current day
                @plan[index][:hours] += task.time_required
                @plan[index][:tasks] << task

            else 
                #If the plan didn't fit, go to next day
                index += 1 

                # Wrap tasks back to 0, even if it flows over desired working hours"
                if index >= timeframe
                    index = 0
                else 
                    # If it has just moved to new spot within index
                    if @plan.length == index
                        @plan[index] = Hash.new
                        @plan[index][:hours] = 0.0
                        @plan[index][:tasks] = []
                    end
                end
                
                @plan[index][:hours] += task.time_required
                @plan[index][:tasks] << task
            end
        end
    end
    

    # Print the Schedule as it exists now. (Potentially unoptimised)
    def print_plan
        today = Date.today
        @plan.each_with_index do |day, index|

            print "#{index+1}. #{Date::DAYNAMES[(today+index).cwday%7]} with #{day[:hours]} hours of work:\n\t"
            
            # Skip empty days
            if day[:tasks].length == 0
                puts '- REST -'
                puts
                next
            end

            day[:tasks].each do |task| 
                print "ID: #{task.id}\tTitle: #{task.title}\t (#{task.time_required} hours)\n\t"
            end
            puts
        end
    end
end