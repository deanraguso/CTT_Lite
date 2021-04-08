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
        prompt = TTY::Prompt.new
        @id = id
        
        @name = prompt.ask("Please enter a user name: ") do |q|
            q.validate -> (input) {input.length > 0}
            q.messages[:valid?] = "Error: User name cannot be blank!"
        end

        @password = BCrypt::Password.create(
            prompt.mask("Please enter a password: ", required: true) do |q|
                q.validate -> (input) {input.length > 0}
                q.messages[:valid?] = "Error: User name cannot be blank!"
            end
        )
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