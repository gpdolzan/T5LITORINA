require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:sala_101)
    @professor = professors(:professor_matematica)
    
    # Login como administrador
    post login_path, params: { email: "admin@teste.com", password: "admin123" }
  end

  test "deve listar todas as salas" do
    get rooms_path
    assert_response :success
    assert_select "h1", "Salas"
    assert_select "table.table-striped tbody tr", minimum: 2
  end

  test "deve mostrar sala específica" do
    get room_path(@room)
    assert_response :success
    assert_select "h5.card-title", /Sala #{@room.number}/
  end

  test "deve mostrar formulário para criar nova sala" do
    get new_room_path
    assert_response :success
    assert_select "h1", "Nova Sala"
  end

  test "deve criar nova sala" do
    assert_difference('Room.count') do
      post rooms_path, params: { room: { number: "103", building: "Bloco C", capacity: 40 } }
    end
    assert_redirected_to rooms_path
  end

  test "deve mostrar formulário para editar sala" do
    get edit_room_path(@room)
    assert_response :success
    assert_select "h1", "Editar Sala"
  end

  test "deve atualizar sala" do
    patch room_path(@room), params: { room: { building: "Bloco Atualizado" } }
    assert_redirected_to rooms_path
    @room.reload
    assert_equal "Bloco Atualizado", @room.building
  end

  test "deve excluir sala" do
    assert_difference('Room.count', -1) do
      delete room_path(@room)
    end
    assert_redirected_to rooms_path
  end

  test "deve redirecionar para confirmação ao tentar atribuir sala a professor que já tem sala" do
    # Professor já tem uma sala (sala_102)
    professor = professors(:professor_matematica)
    
    post rooms_path, params: { room: { number: "104", building: "Bloco D", capacity: 35, professor_id: professor.id } }
    
    assert_response :redirect
    assert_redirected_to %r{/rooms/\d+/confirm_reassign}
  end
end
