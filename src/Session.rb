require_relative "TaskManager.rb"
require_relative "UserManager.rb"
require_relative "Task.rb"
require_relative "User.rb"
require_relative "Calendar.rb"


class Session
    def initialize
        # Handle all Help Flags
        handle_help

        # Initialize the User Database and Login
        @um = UserManager.new
        @um.menu

        # Once Signed in, pass id as activation down to 
        @tm = TaskManager.new(@um.user.id)

        menu
    end

    def menu
        loop do
            if @um.signed_in
                print_menu
                handle_menu
            else
                puts "Not Signed In!"
                @um.menu
            end
        end
    end

    def handle_help
        if (ARGV.length >= 1) && is_help_flag(ARGV[0])
            puts "You included a help flag"
            # helper(menu_selection) (Handles help flags)
            exit
        else
            # Continue as normal
        end
    end

    def is_help_flag(arg_string)
        return arg_string.include?("-h") || arg_string.include?("--help")
    end

    def print_menu
        puts "Welcome to CTT-Lite"
        puts "n: New Task"
        puts "s [task id]: Show Task"
        puts "e [task id]: Edit Task"
        puts "d [task id]: Delete Task"
        puts "c [days]: Print Calendar"
        puts "o: Optimise Schedule"
        puts "q: Sign Out"
        puts "exit: Close Application"
    end

    def sign_out
        @um.sign_out
        @um.menu

        # Essentially, if you log out, you must log into a new valid user. 
        @tm = TaskManager.new(@um.user.id)
    end

    def handle_menu
        menu_selection = gets.chomp

        if (menu_selection.include? " ")
            # When an input argument is given.
            menu_args = menu_selection.split(' ')

            arg = menu_args[1].to_i
            ms = menu_args[0]

        elsif (['n', 'q', "exit"].include?(menu_selection))
            # Features that won't require an input argument.
            ms = menu_selection
        else
            # Features that do require an input argument.
            ms = menu_selection
            print "Enter a valid Task ID: "
            arg = gets.chomp.to_i
        end

        case ms
            when "s"
                @tm.get_task(arg).print_task
            when "n"
                @tm.new_task
            when "e"
                @tm.edit_task(arg)
            when "d"
                @tm.destroy_task(arg)
            when "c"
                @tm.create_calendar(arg)
                @tm.print_calendar
            when "o"
                # Calendar.optimise()
            when "q"
                sign_out
            when "exit"
                exit
            else
                puts "That command was not recognized."
        end
    end
end