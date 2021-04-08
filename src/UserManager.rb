class UserManager
    attr_reader :signed_in, :user

    def initialize
        # Load Config
        @u_db_address = ""
        @u_db_config_address = ""
        load_config

        # Load in User DataBase
        @db = []
        load_db

        #Initialize User
        @signed_in = false
        @user = User.new #To avoid errors
    end

    def menu
        prompt = TTY::Prompt.new
        response = prompt.select("CTT-Lite", [
            { name: "Sign In", value: "s" },
            { name: "Create Account", value: "c" },
            { name: "Exit", value: "exit" }
        ])
        handle_menu(response)
        system "clear"
    end

    def handle_menu(response)
        case response
        when "s"
            sign_in
        when "c"
            new_user
        when "exit"
            exit
        else
            menu
        end
    end

    def load_config
        settings_file = File.open("./config/u_settings.txt","r")
        config = settings_file.readlines()

        @u_db_address = config[0].split(":")[1].chomp
        @u_db_config_address = config[1].split(":")[1].chomp
        settings_file.close
    end 

    def load_db
        db_string_arr = File.readlines(@u_db_address)
        db_string_arr.each do |line|
            # f for fields
            f = line.split(",") 
            user = User.new

            # Coerce data into original types (other 2 already string)
            f[0] = f[0].to_i
            f[1] = f[1].chomp
            f[2] = f[2].chomp
        
            #Push into DB
            user.load(f[0], f[1], f[2])
            @db << user
        end
    end

    def save_db
        db_fp = File.open(@u_db_address, "w")
        @db.each do |user|
            db_fp.write(user.to_s + "\n")
        end
        db_fp.close
    end

    def get_next_id
        # Get the Unique next task ID
        next_id = File.read(@u_db_config_address).split(":")[1].to_i

        #Increment the task ID so the next retrieval is also unique
        db_config_fp = File.open(@u_db_config_address, "w")
        db_config_fp.write("Next Unique Task ID:#{(next_id + 1)}")
        db_config_fp.close

        return next_id
    end

    def new_user
        u = User.new
        u.create(get_next_id)
        @db << u
        save_db
        @signed_in = true

        return u #User should be signed in after creation
    end

    def get_user(id=0)
        u = @db.select do |row| 
            row.id == id 
        end

        # Later, include validation.
        return u[0] if u.length == 1
    end

    def destroy_user(id)
        @db = @db.select() { |user| user.id != id}
        save_db
    end

    def edit_user(id)
        destroy_user(id)
        u = User.new
        u.create(id)
        @db << u
        save_db
    end

    def sign_in
        prompt = TTY::Prompt.new
        response = prompt.select("Please select your username:", 
            @db.map(){ |user| {name: user.id.to_s + " - " + user.name, value: user.id}}
                    .sort_by {|obj| obj[:value]} )

        user = get_user(response)
        
        pw = prompt.ask("Please enter your account password: ") do |q|
            q.validate -> (input) {user.password_match(input)}
            q.messages[:valid?] = "Error: Incorrect Password!"
        end
        
        # Authenticate Login
        if user.password_match(pw)
            @signed_in = true
            @user = user
            puts "You are now logged in!"
        else
            "You entered the incorrect password!"
            exit
        end
    end

    def sign_out
        @signed_in = false
        puts "You are now signed out!"
    end
end