# FAKE SIGA UFPR

Um sistema que imita (de maneira não tão aprofundada) o SIGA da UFPR.

## Requisitos

- Ruby 3.3.4
- Rails 7.2.2.1
- Banco de dados: SQLite

## Aviso importante

Deixo avisado que eu rodei e testei essa aplicação em minha máquina imitando a versão do ruby e do rails encontrado na litorina, por isso eu peço que se qualquer dúvida ou erro surgir que entre em contato comigo pelo meu e-mail: gpd20@inf.ufpr.br, vou responder o mais rápido que eu puder.

## Instruções para configurar e rodar a aplicação

1. Navegue até o diretório do projeto:

```
cd <caminho/do/projeto>
```

3. Instale as gems necessárias:

```
bundle install
```

4. Crie o banco de dados, execute as migrações e popule os dados iniciais:

```
rails db:create
rails db:migrate
rails db:seed
```

Ou tudo de uma vez com o seguinte comando:

```
rails db:create db:migrate db:seed
```

5. Inicie o servidor Rails:

```
rails server
```

6. Acesse a aplicação no seu navegador em `http://localhost:3000`

## Contas de Usuário Padrão

Após executar o seed, as seguintes contas estarão disponíveis:

1. Administrador:

   - Email: admin@teste.com
   - Senha: admin123

2. Usuário Regular:
   - Email: aluno@teste.com
   - Senha: aluno123

## Funcionalidades

- Sistema de login
- Autenticação de usuários com papéis de administrador e usuário comum
- Gerenciamento de professores (relacionamento 1-para-1 com Salas)
- Gerenciamento de salas
- Gerenciamento de disciplinas (relacionamento 1-para-muitos com Professores)
- Matrículas de usuários em disciplinas (relacionamento muitos-para-muitos)
- Controle de acesso baseado em papéis (views do rails)

## Relacionamentos

- 1x1: Cada Professor é designado para exatamente uma Sala
- 1xN: Um Professor leciona várias Disciplinas, mas cada Disciplina tem apenas um Professor
- NxN: Um Usuário pode estar matriculado em várias Disciplinas, e cada Disciplina pode ter vários Usuários matriculados

### Comportamento de Exclusão nos Relacionamentos

#### 1x1: Professor e Sala

- Se um professor for excluído, a sala permanece no sistema, mas fica sem professor atribuído
- Se uma sala for excluída, o professor permanece no sistema, mas fica sem sala atribuída

#### 1xN: Professor e Disciplinas

- Se um professor for excluído, todas as disciplinas que ele leciona também são excluídas automaticamente
- Se uma disciplina for excluída, o professor não é afetado e continua com suas outras disciplinas

#### NxN: Usuários e Disciplinas

- Se um usuário for excluído, ele é automaticamente desvinculado de todas as disciplinas em que estava matriculado
- Se uma disciplina for excluída, todos os usuários matriculados nela perdem o acesso, mas continuam com acesso às demais disciplinas

## Tecnologias Utilizadas

Como solicitado pelo enunciado do trabalho, estou utilizando javascript.

## Executando Testes

Execute o rake test:

```
rake test
```

### Sobre os Testes Implementados

Os testes implementados neste projeto verificam:

1. **Modelos**: Validações de dados, relacionamentos entre modelos e comportamento de exclusão
2. **Controladores**: Funcionamento correto do login e logout
3. **Relacionamentos**: Verificação dos relacionamentos 1x1, 1xN e NxN definidos nos requisitos do trabalho
