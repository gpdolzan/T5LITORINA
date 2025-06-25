class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_room, only: [:show, :edit, :update, :destroy, :confirm_reassign]
  
  def index
    @rooms = Room.all
  end
  
  def show
  end
  
  def new
    @room = Room.new
    @professors = Professor.all
  end
  
  def create
    @room = Room.new(room_params)
    professor_id = room_params[:professor_id].presence
    
    if professor_id.present?
      professor = Professor.find(professor_id)
      
      if professor.room.present? && !params[:confirmed]
        # Professor já tem uma sala atribuída, redireciona para confirmação
        session[:pending_room] = room_params
        new_room = Room.new(number: room_params[:number], building: room_params[:building], capacity: room_params[:capacity])
        new_room.id = 0 # Valor temporário para o redirecionamento
        return redirect_to confirm_reassign_room_path(new_room, professor_id: professor.id)
      end
      
      # Se houve confirmação ou o professor não tinha sala antes, limpa qualquer vinculação anterior
      if params[:confirmed] || professor.room.blank?
        Room.where(professor_id: professor.id).update_all(professor_id: nil)
      end
    end
    
    if @room.save
      redirect_to rooms_path, notice: "Sala foi criada com sucesso."
    else
      @professors = Professor.all
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @professors = Professor.all
  end
  
  def update
    professor_id = room_params[:professor_id].presence
    
    if professor_id.present?
      professor = Professor.find(professor_id)
      
      # Verifica se está tentando atribuir a sala a um professor que já tem sala
      if professor.room.present? && professor.room.id != @room.id && !params[:confirmed]
        # Professor já tem uma sala atribuída, redireciona para confirmação
        session[:pending_room_update] = room_params
        return redirect_to confirm_reassign_room_path(@room, professor_id: professor.id, update: true)
      end
      
      # Se houve confirmação ou o professor não tinha sala antes, limpa qualquer vinculação anterior
      if (params[:confirmed] && professor.room.present? && professor.room.id != @room.id) || professor.room.blank?
        Room.where(professor_id: professor.id).update_all(professor_id: nil)
      end
    end
    
    # Atualiza a sala para o novo professor (ou nenhum)
    if @room.update(room_params)
      redirect_to rooms_path, notice: "Sala foi atualizada com sucesso."
    else
      @professors = Professor.all
      render :edit, status: :unprocessable_entity
    end
  end
  
  def confirm_reassign
    @professor = Professor.find(params[:professor_id])
    @current_room = @professor.room
    @is_update = params[:update] == "true"
    
    # Se não houver sala atual para o professor, redireciona de volta
    unless @current_room
      redirect_to rooms_path, alert: "Erro: O professor não possui sala atribuída."
    end
  end
  
  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "Sala foi excluída com sucesso."
  end
  
  private
  
  def set_room
    if params[:id] == '0'
      @room = Room.new
      if session[:pending_room].present?
        @room.number = session[:pending_room]["number"]
        @room.building = session[:pending_room]["building"]
        @room.capacity = session[:pending_room]["capacity"]
      end
    else
      @room = Room.find(params[:id])
    end
  end
  
  def room_params
    params.require(:room).permit(:number, :building, :capacity, :professor_id)
  end
end
