class Session
    def initialize
        print_menu
    end

    def print_menu
        puts "Welcome to CTT-Lite"
        puts "Assumes Signed In"
        puts "n: New Task"
        puts "e: Edit Task"
        puts "d: Delete Task"
        puts "c -[days]: Print Calendar"
        puts "o: Optimise Schedule"
    end
end