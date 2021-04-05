require 'Task.rb'
class Schedule
    def initialize(duration)
        @duration = duration
        @plan = [[]]
        @total_work_hours = get_work_hours(@plan)
        @rest_days = [6,0] 
        @working_hours = 8
        @safety_factor = 1.5
    end

    def get_work_hours(@plan)
        total_hours = 0
        @plan.each do |day| 
            day.each do |task|
                total_hours += task.time_required
            end
        end
    end

    def sufficient_time? (timeframe)
        return timeframe*@working_hours >= @working_hours
    end

    def form_schedule(timeframe=7)
        if sufficient_time?(timeframe)
            count = 0
                while (count <= timeframe)
        else
            puts "There is insufficient time in a #{timeframe} day 
            window to complete the tasks on your schedule!"
        end
    end

    def print_schedule
        @schedule.each do |day|
            p day
        end
    end
end