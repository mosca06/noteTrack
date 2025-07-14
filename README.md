# noteTrack
Sistema de Empréstimo de Notebooks
Sistema simples para gerenciar empréstimos de notebooks para clientes, com controle de status e devoluções.

Funcionalidades
- CRUD de clientes, notebooks e empréstimos (handovers)
- Controle de status do empréstimo (aberto, devolvido)
- Controle do estado inicial e final do notebook no empréstimo
- Formulário para finalizar empréstimos (devolução ou baixa)
- Exibição de status colorida no índice e na página de detalhes

Tecnologias
- Ruby on Rails
- PostgreSQL (ou outro banco de dados relacional)
- RSpec para testes
- RuboCop para análise e padronização do código
- SimpleCov para cobertura de testes

Instalação
Clone o repositório:

```bash
git clone https://github.com/mosca06/noteTrack
cd noteTrack
```

Instale as gems:

```bash
bundle install
```
Configure o banco de dados (config/database.yml), depois:
```bash
rails db:create db:migrate
```
Rode os testes para garantir que está tudo certo:

```bash
bundle exec rspec
```
Inicie o servidor:

```bash
rails server
```
Acesse http://localhost:3000 no navegador.

RuboCop
Para manter a qualidade e padronização do código, o projeto utiliza o RuboCop. Para executar a análise, rode:

```bash
bundle exec rubocop
```
Testes
O projeto inclui testes RSpec para as principais funcionalidades.

```bash
bundle exec rspec
```
Link do projeto no GitHub
Você pode acompanhar o progresso e o gerenciamento das tarefas do projeto neste link:

[Projeto no GitHub - Mosca06](https://github.com/users/mosca06/projects/12/)

Uso
- Crie clientes e notebooks
- Registre um empréstimo (handover) entre cliente e notebook
- Finalize o empréstimo usando o formulário de devolução ou baixa
- Acompanhe os status e estados nos índices e telas de detalhes


