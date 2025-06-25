ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Rodar em paralelo para acelerar os testes
  parallelize(workers: :number_of_processors)

  fixtures :all
  
  # Helper para verificar se um usuário está logado
  def is_logged_in?
    session[:user_id].present?
  end
  
  # Helper para logar um usuário nos testes
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

# Classe para permitir login nos testes de integração
class ActionDispatch::IntegrationTest
  # Login para testes de integração
  def log_in_as(user, password: 'password')
    post login_path, params: { email: user.email, password: password }
  end
end
