require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "deve mostrar página de login" do
    get login_path
    assert_response :success
    assert_select "h2", "Entrar no FAKE SIGA UFPR"
  end

  test "deve fazer login com credenciais válidas" do
    post login_path, params: { email: "admin@teste.com", password: "admin123" }
    assert_redirected_to root_path
    follow_redirect!
    assert_select ".nav-link", /Bem-vindo/
  end

  test "não deve fazer login com credenciais inválidas" do
    post login_path, params: { email: "admin@teste.com", password: "senha_errada" }
    assert_response :success
    assert_select "h2", "Entrar no FAKE SIGA UFPR"
  end

  test "deve fazer logout" do
    post login_path, params: { email: "admin@teste.com", password: "admin123" }
    assert_redirected_to root_path
    
    get logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select ".nav-link", "Entrar"
  end
end
