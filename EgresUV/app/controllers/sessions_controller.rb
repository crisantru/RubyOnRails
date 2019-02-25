class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user

      #if user.rol.eql? "admin"
        #render action: "admin"
      #end

      #if user.rol.eql? "estandar"
        #render action: "estandart"
      #end
      

      render action: "welcome"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end



    #if user.rol.eql? "admin"
   # render action: "admin"

  #end
   #if user.rol.eql? "estandar"
    #render action: "estandart"
  #end

    
    
  end

  def destroy
  	log_out
    redirect_to root_url
  end
end