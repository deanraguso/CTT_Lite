require_relative "Task.rb"

class TaskManager
    def initialize
        # Database loads into array db
        @db_address = ""
        @db_config_address = ""
        @db = []

        # Load session files
        load_config

        # Load in DB
        load_db
    end

    def load_config
        settings_file = File.open("./config/settings.txt","r")
        config = settings_file.readlines()

        @db_address = config[0].split(":")[1].chomp
        @db_config_address = config[1].split(":")[1].chomp
    end 

    def save_task(task)
        db_fp = File.open(@db_address, "a")
        task_string = task.to_s + "\n"
        db_fp.write(task_string)
        db_fp.close
    end

    def load_db
        @db = File.readlines(@db_address)
    end

    def get_next_id
        # Get the Unique next task ID
        next_id = File.read(@db_config_address).split(":")[1].to_i
        puts next_id

        #Increment the task ID so the next retrieval is also unique
        db_config_fp = File.open(@db_config_address, "w")
        db_config_fp.write("Next Unique Task ID:#{(next_id + 1)}")
        db_config_fp.close

        return next_id
    end

    def load_task
        t = Task.new(0)
        t.load_from_s(@db_fp.read)
        
        return t
    end

    def new_task
        t = Task.new(get_next_id) #Must change number
        t.create
        save_task(t)
    end

    def edit_task

    end

    def destroy_task

    end

    def view_task

    end
end