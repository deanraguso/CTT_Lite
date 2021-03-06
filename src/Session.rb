require_relative "TaskManager.rb"
require_relative "UserManager.rb"
require_relative "Task.rb"
require_relative "User.rb"
require_relative "Calendar.rb"
require 'tty-prompt'


class Session
    def initialize
        # Handle Help Flag
        handle_help

        # Initialize the User Database and Login
        @um = UserManager.new
        @um.menu

        # Once Signed in, pass id as activation down to 
        @tm = TaskManager.new(@um.user.id)

        app_menu
    end

    # Menu for application.
    def app_menu
        loop do
            if @um.signed_in
                main_menu
            else
                puts "Not Signed In!"
                @um.menu
            end
        end
    end

    # Handles when users input a help flag, (./ctt.sh -h or ./ctt.sh --help)
    def handle_help
        if (ARGV.length >= 1) && is_help_flag?(ARGV[0])
            puts "Detailed Instructions on application use can be found in the README.md file."
            puts "Look under the Installation heading for more information!"
            exit
        else
            # Continue as normal
        end
    end

    def is_help_flag?(arg_string)
        return arg_string.include?("-h") || arg_string.include?("--help")
    end

    # Main Menu, once you have signed in. (Task options, Calender Options, Sign Out and Exit)
    def main_menu
        prompt = TTY::Prompt.new(active_color: :blue)
        response = prompt.select("CTT-Lite", available_options)
        system "clear"
        handle_main_menu(response)
    end

    # Handles response to main_menu
    def handle_main_menu(response)
        prompt = TTY::Prompt.new

        if (['n', 'q', 'o', 'c', "exit"].include?(response))
            # Features that won't require an extra input argument.
            case response
            when "n"
                @tm.new_task
            when "q"
                sign_out
            when "exit"
                exit
            when "o"
                @tm.calendar.options
            when "c"
                @tm.create_calendar
                @tm.print_calendar
            else
                puts "Error: Argument not accounted for!"
                raise 
            end
        else
            # Features that require an input argument.
            arg = prompt.select("Enter a valid Task ID: ", 
                        @tm.available_tasks
                        .map {|task| {name: "#{task.id.to_s} - #{task.title}",
                                      value: task.id}})

            case response
                when "s"
                    t = @tm.get_task(arg)
                    t.print_task unless t==-1
                when "e"
                    @tm.edit_task(arg)
                when "d"
                    ans = prompt.yes?("Are you sure you want to delete task #{arg}?") do |q|
                        q.suffix "Yes/No"
                    end

                    if ans
                        @tm.destroy_task(arg)
                    end
                when "c"
                    @tm.create_calendar(arg)
                    @tm.print_calendar
                else
                    puts "Error: Argument not accounted for!"
                    raise 
            end
        end
    end

    # Generates Options to be displayed in main menu dynamically.
    def available_options 
        o = 
        [{ name: "New Task", value: "n" }]

        # To avoid trying to iterate over nill arrays, only give option that requires selection of a task if
        # the user has tasks, using has_entries? method.
        if @tm.has_entries? 
            o += [
                { name: "Show Task", value: "s" },
                { name: "Edit Task", value: "e" },
                { name: "Delete Task", value: "d" },
                { name: "Print Calendar", value: "c" },
                { name: "Calendar Options", value: "o" }
            ]
        end
        
        o += [ 
            { name: "Sign Out", value: "q" },
            { name: "Exit", value: "exit" }
        ]   
        
        return o
    end

    def sign_out
        @um.sign_out
        @um.menu

        # Essentially, if you log out, you must log into a new valid user. 
        @tm = TaskManager.new(@um.user.id)
    end
end