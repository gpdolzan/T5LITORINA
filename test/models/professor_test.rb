require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase
  test "professor deve ser válido" do
    professor = Professor.new(name: "Professor Teste", specialization: "Computação")
    assert professor.valid?
  end

  test "professor deve ter nome" do
    professor = Professor.new(specialization: "Computação")
    assert_not professor.valid?
  end

  test "professor deve ter especialização" do
    professor = Professor.new(name: "Professor Teste")
    assert_not professor.valid?
  end

  test "professor pode ter uma sala" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    room = Room.create(number: "401", building: "Bloco A", capacity: 30, professor: professor)
    
    # Verificamos se o professor_id da sala está corretamente definido
    assert_equal professor.id, room.professor_id
  end

  test "professor pode ter várias disciplinas" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    discipline1 = Discipline.create(name: "Disciplina 1", code: "DISC01", description: "Descrição 1", credits: 4, professor: professor)
    discipline2 = Discipline.create(name: "Disciplina 2", code: "DISC02", description: "Descrição 2", credits: 4, professor: professor)
    
    professor.reload
    assert_equal 2, professor.disciplines.count
  end

  test "excluir professor deve excluir suas disciplinas" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    discipline = Discipline.create(name: "Disciplina Teste", code: "DISC-T", description: "Descrição Teste", credits: 4, professor: professor)
    
    assert_difference 'Discipline.count', -1 do
      professor.destroy
    end
  end

  test "excluir professor não deve excluir sua sala" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    room = Room.create(number: "402", building: "Bloco A", capacity: 30, professor: professor)
    
    room_id = room.id
    
    assert_no_difference 'Room.count' do
      professor.destroy
    end

    # Verificamos se a sala ainda existe, mas agora sem professor
    room = Room.find(room_id)
    assert_nil room.professor_id
  end
end
