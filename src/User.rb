class User
    attr_reader :id, :name
    def initialize(id=999)
        @id = id
        @name = ""
        @password = ""
    end

    def password_match(pw)
        return @password == pw
    end

    def create(id)
        @id = id
        print "Please enter a user name: "
        @name = gets.chomp

        print "Please enter a password: "
        @password = gets.chomp
    end

    def load(id, name, password)
        @id = id
        @name = name
        @password = password
    end

    def to_s
        user_string = @id.to_s + "," + @name + "," + @password.chomp
    end
end