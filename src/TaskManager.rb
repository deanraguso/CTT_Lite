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
        puts @db[0][8].class
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

    # Restores db from persistent memory
    def load_db
        db_string_arr = File.readlines(@db_address)
        db_string_arr.each do |line|
            fields = line.split(",")

            # Coerce data into original types
            fields[0] = fields[0].to_i
            fields[3] = fields[3] == "true"
            fields[4] = fields[4].to_i
            fields[5] = fields[5].to_i
            fields[6] = fields[6].to_f
            fields[7] = Date.parse fields[7]
            fields[8] = Date.parse fields[8]

            #Push into DB
            @db << fields
        end
    end

    def get_next_id
        # Get the Unique next task ID
        next_id = File.read(@db_config_address).split(":")[1].to_i

        #Increment the task ID so the next retrieval is also unique
        db_config_fp = File.open(@db_config_address, "w")
        db_config_fp.write("Next Unique Task ID:#{(next_id + 1)}")
        db_config_fp.close

        return next_id
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

    def show_task(id=0)
        t = @db.select()
    end
end