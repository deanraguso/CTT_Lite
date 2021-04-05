require_relative "TaskManager.rb"
require_relative "UserManager.rb"
require_relative "Task.rb"
require_relative "User.rb"
require_relative "Calendar.rb"


class Session
    def initialize
        @tm = TaskManager.new
        @um = UserManager.new
        # @um.menu (Login Menu)
        handle_help
        menu
    end

    def menu
        loop do
            print_menu
            handle_menu
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
        puts "e [task id]: Edit Task"
        puts "d [task id]: Delete Task"
        puts "c -[days]: Print Calendar"
        puts "o: Optimise Schedule"
    end

    def handle_menu
        menu_selection = gets.chomp
        ms_first = menu_selection[0]
        case ms_first
        when "n"
            # TaskManager.new
        when "e"
            # TaskManager.edit(menu_selection) May be null input
        when "d"
            # TaskManager.delete(menu_selection) May be null input
        when "c"
            # Calendar.print(menu_selection) May be null
        when "o"
            # Calendar.optimise()
        else
            puts "That command was not recognized."
        end
    end
end