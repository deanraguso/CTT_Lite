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

    # Restores db from persistent memory
    def load_db
        db_string_arr = File.readlines(@db_address)
        db_string_arr.each do |line|
            # f for fields
            f = line.split(",") 
            task = Task.new

            # Coerce data into original types
            f[0] = f[0].to_i
            f[3] = f[3] == "true"
            f[4] = f[4].to_i
            f[5] = f[5].to_i
            f[6] = f[6].to_f
            f[7] = Date.parse f[7]
            f[8] = Date.parse f[8]

            #Push into DB
            task.load(f[0], f[1], f[2], f[3], f[4], f[5],f[6],f[7],f[8])
            @db << task
        end
    end

    def save_db
        db_fp = File.open(@db_address, "w")
        @db.each do |task|
            db_fp.write(task.to_s + "\n")
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

    def edit_task(id = 0)
        
    end

    def destroy_task(id=0)
        @db = @db.filter() { |task| task.id != id}
        save_db
    end

    def get_task(id=0)
        return t = @db.select { |row| row.id == id}
    end
end