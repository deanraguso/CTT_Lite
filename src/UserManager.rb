class UserManager
    attr_reader :signed_in

    def initialize
        # Load Config

        #Initialize User
        @signed_in = false
        @user = User.new #To avoid errors
    end

    def sign_in
        
    end

    def sign_out

    end

    def create_login

    end
end