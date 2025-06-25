require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  setup do
    @professor = Professor.create(name: "Professor Teste", specialization: "Computação")
  end

  test "disciplina deve ser válida" do
    discipline = Discipline.new(
      name: "Disciplina Teste", 
      code: "DISC-T", 
      description: "Descrição da disciplina", 
      credits: 4, 
      professor: @professor
    )
    assert discipline.valid?
  end

  test "disciplina deve ter nome" do
    discipline = Discipline.new(
      code: "DISC-T", 
      description: "Descrição da disciplina", 
      credits: 4, 
      professor: @professor
    )
    assert_not discipline.valid?
  end

  test "disciplina deve ter código" do
    discipline = Discipline.new(
      name: "Disciplina Teste", 
      description: "Descrição da disciplina", 
      credits: 4, 
      professor: @professor
    )
    assert_not discipline.valid?
  end

  test "código da disciplina deve ser único" do
    Discipline.create(
      name: "Disciplina 1", 
      code: "DISC-T", 
      description: "Descrição 1", 
      credits: 4, 
      professor: @professor
    )
    
    discipline2 = Discipline.new(
      name: "Disciplina 2", 
      code: "DISC-T", 
      description: "Descrição 2", 
      credits: 3, 
      professor: @professor
    )
    
    assert_not discipline2.valid?
  end

  test "disciplina deve ter descrição" do
    discipline = Discipline.new(
      name: "Disciplina Teste", 
      code: "DISC-T", 
      credits: 4, 
      professor: @professor
    )
    assert_not discipline.valid?
  end

  test "disciplina pertence a um professor" do
    discipline = Discipline.create(
      name: "Disciplina Teste", 
      code: "DISC-T", 
      description: "Descrição da disciplina", 
      credits: 4, 
      professor: @professor
    )
    
    assert_equal @professor, discipline.professor
  end

  test "disciplina pode ter vários alunos matriculados" do
    discipline = Discipline.create(
      name: "Disciplina Teste", 
      code: "DISC-T", 
      description: "Descrição da disciplina", 
      credits: 4, 
      professor: @professor
    )
    
    user1 = User.create(name: "Aluno 1", email: "aluno1@teste.com", password: "senha123", password_confirmation: "senha123")
    user2 = User.create(name: "Aluno 2", email: "aluno2@teste.com", password: "senha123", password_confirmation: "senha123")
    
    discipline.users << user1
    discipline.users << user2
    
    assert_equal 2, discipline.users.count
  end
end
