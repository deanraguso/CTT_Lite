require 'bcrypt'
require 'byebug'

class User
    attr_reader :id, :name, :password
    def initialize(id=999)
        @id = id
        @name = ""
        @password = ""
    end

    def password_match(pw)
        bcrypt_password = BCrypt::Password.new(@password)
        return bcrypt_password == pw.chomp
    end

    def create(id)
        @id = id
        print "Please enter a user name: "
        @name = gets.chomp

        print "Please enter a password: "
        x = gets.chomp
        p x
        @password = BCrypt::Password.create(x)
    end

    def load(id, name, password)
        @id = id
        @name = name
        @password = BCrypt::Password.new(password)
    end

    def to_s
        user_string = @id.to_s + "," + @name + "," + @password.chomp
    end
end