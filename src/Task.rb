require 'date' 

class Task
    attr_reader :creation_time, :time
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
        puts "Due: #..."
        puts "Created On: #{@creation_time}"
    end

    def to_CSV
        
    end
end