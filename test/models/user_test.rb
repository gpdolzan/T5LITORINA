require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "usuário deve ser válido" do
    user = User.new(name: "Teste Usuário", email: "teste@exemplo.com", password: "senha123", password_confirmation: "senha123")
    assert user.valid?
  end

  test "usuário deve ter nome" do
    user = User.new(email: "teste@exemplo.com", password: "senha123", password_confirmation: "senha123")
    assert_not user.valid?
  end

  test "usuário deve ter email" do
    user = User.new(name: "Teste Usuário", password: "senha123", password_confirmation: "senha123")
    assert_not user.valid?
  end

  test "email deve ser único" do
    user1 = User.create(name: "Teste Usuário 1", email: "mesmo@exemplo.com", password: "senha123", password_confirmation: "senha123")
    user2 = User.new(name: "Teste Usuário 2", email: "mesmo@exemplo.com", password: "senha123", password_confirmation: "senha123")
    assert_not user2.valid?
  end

  test "senha e confirmação de senha devem corresponder" do
    user = User.new(name: "Teste Usuário", email: "teste@exemplo.com", password: "senha123", password_confirmation: "outra_senha")
    assert_not user.valid?
  end

  test "usuário pode ser matriculado em várias disciplinas" do
    user = User.create(name: "Teste Usuário", email: "teste@exemplo.com", password: "senha123", password_confirmation: "senha123")
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    discipline1 = Discipline.create(name: "Disciplina 1", code: "DISC01", description: "Descrição 1", horas: 4, professor: professor)
    discipline2 = Discipline.create(name: "Disciplina 2", code: "DISC02", description: "Descrição 2", horas: 4, professor: professor)
    
    user.disciplines << discipline1
    user.disciplines << discipline2
    
    assert_equal 2, user.disciplines.count
  end
end
