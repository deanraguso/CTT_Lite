require_relative "TaskManager.rb"
require_relative "UserManager.rb"
require_relative "Task.rb"
require_relative "User.rb"
require_relative "Calendar.rb"


class Session
    def initialize
        @tm = TaskManager.new
        @um = UserManager.new
        handle_help
        menu
    end

    def menu
        loop do
            if @um.is_logged_in?
                print_menu
                handle_menu
            else
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
        puts "Assumes Signed In"
        puts "n: New Task"
        puts "s [task id]: Show Task"
        puts "e [task id]: Edit Task"
        puts "d [task id]: Delete Task"
        puts "c [days]: Print Calendar"
        puts "o: Optimise Schedule"
        puts "exit: Close Application"
    end

    def handle_menu
        menu_selection = gets.chomp

        if (menu_selection.include? " ")
            # When an input argument is given.
            menu_args = menu_selection.split(' ')

            arg = menu_args[1].to_i
            ms = menu_args[0]

        elsif (['n', "exit"].include?(menu_selection))
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
            when "exit"
                exit
            else
                puts "That command was not recognized."
        end
    end
end