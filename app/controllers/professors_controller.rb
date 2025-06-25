class ProfessorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_professor, only: [:show, :edit, :update, :destroy]
  
  def index
    @professors = Professor.all
  end
  
  def show
  end
  
  def new
    @professor = Professor.new
  end
  
  def create
    @professor = Professor.new(professor_params)
    
    if @professor.save
      redirect_to professors_path, notice: "Professor foi criado com sucesso."
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @professor.update(professor_params)
      redirect_to professors_path, notice: "Professor foi atualizado com sucesso."
    else
      render :edit
    end
  end
  
  def destroy
    @professor.destroy
    redirect_to professors_path, notice: "Professor foi excluído com sucesso."
  end
  
  private
  
  def set_professor
    @professor = Professor.find(params[:id])
  end
  
  def professor_params
    params.require(:professor).permit(:name, :specialization, :email, :phone)
  end
end
