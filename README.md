# README

### Pré-requisitos

- ruby "3.0.2"

### Gems utilizadas

- devise token auth (utilizada para autenticação de usuário)
- faker (utilizada para gerar dados aleatórios para o seeds.rb)
- rack-cors (deixar compatível com CORS)

### Executar

- bundle install
- rails db:migrate
- rails db:seed
- rails server

### Suporte

- [x] Cadastrar novas tarefas (pública e privada)
- [x] Tarefas públicas todos os usuários logados podem visualizar
- [x] Tarefas privadas apenas o usuário que criou pode visualizar
- [x] Listar as tarefas cadastradas conforme a visibilidade, pública ou privada
- [x] Listar as tarefas cadastradas conforme o status, nova ou concluída
- [x] Permitir marcar uma tarefa como concluída
- [x] Poder editar uma tarefa
- [x] Uma tarefa concluída não pode ser editada, apenas visualizada, mas se desmarcar ela pode ser editada
- [x] Povoar o banco com uma lista default de tarefas (arquivo seeds.rb)
- [x] Criar uma autenticação básica para o sistema (utilizando devise token auth)
- [x] Uma tarefa é: título, descrição, status(nova ou concluída), visibilidade (publica ou privada)
- [x] Um usuário é: nome, email, senha

### Rotas

| Método | Endpoint             | Descrição                                        |
| ------ | -------------------- | ------------------------------------------------ |
| POST   | /auth                | Criar novo usuário                               |
| DELETE | /auth                | Excluir um usuário                               |
| PUT    | /auth                | Att informações de um usuário                    |
| POST   | /auth/sign_in        | Fazer login                                      |
| DELETE | /auth/sign_out       | Fazer logout                                     |
| GET    | /auth/validate_token | Validar um token                                 |
| GET    | /tasks               | Listar tarefas                                   |
| POST   | /tasks               | Criar tarefas                                    |
| PUT    | /tasks/{id}          | Editar tarefa                                    |
| DELETE | /tasks/{id}          | Excluir tarefa                                   |
| GET    | /tasks/{id}          | Exibir tarefa                                    |
| PUT    | /tasks/status        | Permite que uma tarefa concluida seja desmarcada |
