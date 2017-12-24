module Users
  class UsersController < Users::BaseController
    before_action :authenticate_user!
    
    def show
      @user = current_user  
    end
  
  end
end