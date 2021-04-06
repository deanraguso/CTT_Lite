class User
    def initialize(id=999)
        @id = id
        @name = ""
        @password = ""
    end

    def load_user(id, name, password)

    end

    def to_s
        user_string = @id.to_s + "," + @name + "," + @password
    end
end