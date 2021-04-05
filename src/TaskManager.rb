require_relative "Task.rb"

class TaskManager
    def initialize
        # Database loads into array db
        @db_address = ""
        @db = []

        # Load session files
        load_config
        load_db


    end

    def load_config
        settings_file = File.open("./config/settings.txt","r")
        @db_address = settings_file.read
    end 

    def save_task(task)
        db_fp = File.open(@db_address, "a")
        task_string = task.to_s + "\n"
        db_fp.write(task_string)
        db_fp.close
    end

    def load_db
        @db = File.readlines(@db_address)
        puts(@db[1])
    end

    def load_task
        t = Task.new(0)
        puts @db_fp.read
        t.load_from_s(@db_fp.read)
        return t
    end

    def create_task

    end

    def edit_task

    end

    def destroy_task

    end

    def view_task

    end
end