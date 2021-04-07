require 'date' 

class Task
    attr_reader :id, :time_required, :user_id

    def initialize(id=999, user_id=999)
        @id = id
        @title = ""
        @body = ""
        @completed = false
        @importance = 0
        @urgency = 0
        @time_required = 0
        @creation_time = Date.new
        @due_date = Date.new
        @user_id = user_id
    end
    
    def create
        system 'clear'
        print "Enter task title: "
        @title = gets.chomp

        print "Enter task description: "
        @body = gets.chomp

        print "Enter task importance (1/10): "
        @importance = gets.chomp.to_i

        print "Enter task urgency (1/10): "
        @urgency = gets.chomp.to_i

        print "Enter task estimate duration in hours: "
        @time_required = gets.chomp.to_f

        print "Enter task due date (dd mm yyyy): "
        dd_string = gets.chomp.split()
        due_day = dd_string[0].to_i
        due_month = dd_string[1].to_i
        due_year = dd_string[2].to_i
        @due_date = Date.new(due_year, due_month, due_day)
        @creation_time = Date.today
    end

    def load(id, title="", body="", completed=false, importance=0,
        urgency=0, time_required=0, due_date=Date.today, 
        creation_time=Date.today, user_id)

        @id = id
        @user_id = user_id
        @title = title
        @body = body
        @completed = completed
        @importance = importance
        @urgency = urgency
        @time_required = time_required
        @due_date = due_date
        @creation_time = creation_time
    end

    def print_task
        system 'clear'
        puts "Task ID:#{@id}"
        puts "Title: #{@title}"
        puts "Body: #{@body}"
        puts "Completion Status: #{@completed}"
        puts "Importance: #{@importance}"
        puts "Urgency: #{@urgency}"
        puts "Time Required: #{@time_required}"
        puts "Due: #{@due_date}"
        puts "Created On: #{@creation_time}"
        puts "User ID:#{@user_id}"
        puts
    end

    def to_s
        return  @id.to_s + "," +
                @title.to_s + "," +
                @body.to_s + "," +
                @completed.to_s + "," +
                @importance.to_s + "," +
                @urgency.to_s + "," +
                @time_required.to_s + "," +
                @due_date.to_s + "," +
                @creation_time.to_s + "," +
                @user_id.to_s
    end
end