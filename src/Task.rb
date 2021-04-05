require 'date' 

class Task
    def initialize(id)
        @id = id
        @title = ""
        @body = ""
        @completed = false
        @importance = 0
        @urgency = 0
        @time_required = 0
        @creation_time = Time.new
        @due_date = Time.new
    end

    def print_task
        puts "Task ID:#{@id}"
        puts "Title: #{@title}"
        puts "Body: #{@body}"
        puts "Completion Status: #{@completed}"
        puts "Importance: #{@importance}"
        puts "Urgency: #{@urgency}"
        puts "Time Required: #{@time_required}"
        puts "Due: #{@due_date}"
        puts "Created On: #{@creation_time}"
    end

    def to_CSV
        return  @id.to_s + "," +
                @title.to_s + "," +
                @body.to_s + "," +
                @completed.to_s + "," +
                @importance.to_s + "," +
                @urgency.to_s + "," +
                @time_required.to_s + "," +
                @due_date.to_s + "," +
                @creation_time.to_s + "\n"
    end
end