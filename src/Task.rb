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
        prompt = TTY::Prompt.new
        system 'clear'

        # Prompts
        @title = prompt.ask("Enter task title: ") do |q|
            q.validate -> (input) {input.chomp.length > 0}
            q.messages[:valid?] = "Invalid Title: Title cannot be blank!"
        end
        @body = prompt.ask("Enter task description: ")
        @importance = prompt.slider("Importance: ", min: 0, max: 10, step: 1)
        @urgency = prompt.slider("Urgency: ", min: 0, max: 10, step: 1)
        @time_required = prompt.slider("Task estimate duration in hours: ",
             min: 0, max: 4, step: 0.2)
        @date_response = prompt.ask("Enter task due date (dd/mm/yyyy): ") do |q|
            q.required true
            q.convert :date
            q.validate ->(input) {Date.today <= Date.parse(input)}
            q.messages[:valid?] = "Invalid Date: Date must be in future!"
        end

        #Default Actions
        @creation_time = Date.today
        prompt.ok("Task has been added!\n")
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