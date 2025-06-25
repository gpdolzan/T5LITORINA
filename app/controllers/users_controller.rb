class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_profile, only: [:show]
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to users_path, notice: "Usuário foi criado com sucesso."
    else
      render :new
    end
  end
  
  def edit
  end
    def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário foi atualizado com sucesso."
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path, notice: "Usuário foi excluído com sucesso."
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def authorize_user_profile
    unless current_user.admin? || current_user.id == @user.id
      redirect_to root_path, alert: "Você não tem permissão para ver o perfil de outro usuário."
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
