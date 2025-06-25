class DisciplinesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_discipline, only: [:show, :edit, :update, :destroy, :enroll, :unenroll]
  
  def index
    @disciplines = Discipline.all
  end
  
  def show
    @users = @discipline.users
  end
  
  def new
    @discipline = Discipline.new
    @professors = Professor.all
  end
  
  def create
    @discipline = Discipline.new(discipline_params)
    
    if @discipline.save
      redirect_to disciplines_path, notice: "Disciplina criada com sucesso."
    else
      @professors = Professor.all
      render :new
    end
  end
  
  def edit
    @professors = Professor.all
  end
  
  def update
    if @discipline.update(discipline_params)
      redirect_to disciplines_path, notice: "Disciplina atualizada com sucesso."
    else
      @professors = Professor.all
      render :edit
    end
  end
  
  def destroy
    @discipline.destroy
    redirect_to disciplines_path, notice: "Disciplina foi excluída com sucesso."
  end  
  def enroll
    user = User.find(params[:user_id])
    
    unless @discipline.users.include?(user)
      @discipline.users << user
      redirect_to @discipline, notice: "Usuário matriculado com sucesso nesta disciplina."
    else
      redirect_to @discipline, alert: "Usuário já está matriculado nesta disciplina."
    end
  end
  
  def unenroll
    user = User.find(params[:user_id])
    
    if @discipline.users.include?(user)
      @discipline.users.delete(user)
      redirect_to @discipline, notice: "Matrícula do usuário cancelada com sucesso."
    else
      redirect_to @discipline, alert: "Usuário não está matriculado nesta disciplina."
    end
  end
  
  private
  
  def set_discipline
    @discipline = Discipline.find(params[:id])
  end
  
  def discipline_params
    params.require(:discipline).permit(:name, :code, :description, :credits, :professor_id)
  end
end
