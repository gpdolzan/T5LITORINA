class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "E-mail ou senha inválidos"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Você saiu do sistema com sucesso!"
  end
end
