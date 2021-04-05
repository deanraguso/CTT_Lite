class TaskManager
    def initialize
        @db_address = ""
        @db_fp = nil
        load_config
        @db_fp.close
    end

    def load_config
        settings_file = File.open("./config/settings.txt","r")
        @db_address = settings_file.read
        @db_fp = File.open(@db_address, "a")
    end 

    def reload

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