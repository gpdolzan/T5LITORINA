require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test "sala deve ser válida" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    room = Room.new(number: "201", building: "Bloco A", capacity: 30, professor: professor)
    assert room.valid?
  end

  test "sala deve ter número" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    room = Room.new(building: "Bloco A", capacity: 30, professor: professor)
    assert_not room.valid?
  end

  test "número da sala deve ser único" do
    professor1 = Professor.create(name: "Professor 1", specialization: "Computação")
    professor2 = Professor.create(name: "Professor 2", specialization: "Matemática")
    
    Room.create(number: "301", building: "Bloco A", capacity: 30, professor: professor1)
    room2 = Room.new(number: "301", building: "Bloco B", capacity: 25, professor: professor2)
    
    assert_not room2.valid?
  end

  test "sala pode existir sem professor" do
    room = Room.new(number: "302", building: "Bloco A", capacity: 30, professor_id: nil)
    # Se o modelo Room tem belongs_to :professor, optional: true, este teste deve passar
    assert room.valid?
  end

  test "uma sala pertence a apenas um professor" do
    professor = Professor.create(name: "Professor Teste", specialization: "Computação")
    room = Room.create(number: "303", building: "Bloco A", capacity: 30, professor: professor)
    
    assert_equal professor.id, room.professor_id
  end
end
