# Limpa todos os dados existentes para evitar duplicação
puts "Limpando banco de dados..."
Discipline.destroy_all
Room.destroy_all
Professor.destroy_all
User.destroy_all

# Cria usuário administrador para o professor
admin = User.create!(
  name: 'Administrador',
  email: 'admin@teste.com',
  password: 'admin123',
  role: 'admin'
)

puts "Usuário administrador criado: email: admin@teste.com, senha: admin123"

# Cria usuário regular para demonstração
user = User.create!(
  name: 'Aluno Teste',
  email: 'aluno@teste.com',
  password: 'aluno123',
  role: 'user'
)

puts "Usuário regular criado: email: aluno@teste.com, senha: aluno123"

# Cria professores
professor1 = Professor.create!(
  name: 'Carlos Oliveira',
  specialization: 'Ciência da Computação',
  email: 'carlos@universidade.br',
  phone: '(41) 98765-4321'
)

professor2 = Professor.create!(
  name: 'Ana Souza',
  specialization: 'Engenharia de Software',
  email: 'ana@universidade.br',
  phone: '(41) 91234-5678'
)

professor3 = Professor.create!(
  name: 'Roberto Alves',
  specialization: 'Banco de Dados',
  email: 'roberto@universidade.br',
  phone: '(41) 95555-9999'
)

# Cria salas
room1 = Room.create!(
  number: 'A101',
  building: 'Prédio de Exatas',
  capacity: 30,
  professor: professor1
)

room2 = Room.create!(
  number: 'B202',
  building: 'Prédio de Tecnologia',
  capacity: 25,
  professor: professor2
)

room3 = Room.create!(
  number: 'C303',
  building: 'Prédio Central',
  capacity: 40,
  professor: professor3
)

# Cria disciplinas
discipline1 = Discipline.create!(
  name: 'Programação Orientada a Objetos',
  code: 'CI101',
  description: 'Introdução aos conceitos de programação orientada a objetos utilizando Java.',
  credits: 4,
  professor: professor1
)

discipline2 = Discipline.create!(
  name: 'Estruturas de Dados',
  code: 'CI201',
  description: 'Estudo das principais estruturas de dados e suas aplicações.',
  credits: 4,
  professor: professor1
)

discipline3 = Discipline.create!(
  name: 'Engenharia de Software',
  code: 'CI301',
  description: 'Princípios e práticas de engenharia de software e gerenciamento de projetos.',
  credits: 4,
  professor: professor2
)

discipline4 = Discipline.create!(
  name: 'Banco de Dados',
  code: 'CI202',
  description: 'Modelagem e implementação de bancos de dados relacionais.',
  credits: 4,
  professor: professor3
)

# Matricula alunos em disciplinas
puts "Matriculando alunos em disciplinas..."

# Aluno teste matriculado em várias disciplinas
discipline1.users << user
discipline3.users << user
discipline2.users << user
discipline4.users << user

# O admin não é matriculado em nenhuma disciplina

puts "Dados iniciais criados com sucesso!"
puts "----------------------------------------"
puts "Para testar o sistema, use as seguintes credenciais:"
puts "ADMINISTRADOR: admin@teste.com / admin123"
puts "ALUNO: aluno@teste.com / aluno123"
puts "----------------------------------------"
