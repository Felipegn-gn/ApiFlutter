CRUD de Usuários - Flutter 🚀
Trabalho bimestral desenvolvido para a disciplina de Programação de Dispositivos Móveis. A aplicação consiste em um sistema de gestão de usuários integrado a uma API real (MockAPI).

👤 Identificação
Aluno: Felipe Souza de Jesus Goncalves  

Curso: Análise e Desenvolvimento de Sistemas (4º Semestre)

Instituição: UNICV

🛠️ Tecnologias Principais
Provider: Gerenciamento de estado.

Dio: Consumo de API REST.

GoRouter: Navegação entre telas.

📁 Organização do Projeto (Arquitetura)
O projeto segue o padrão de separação de responsabilidades:

models/: Definição da classe de Usuário e conversão JSON.

services/: Comunicação direta com a API via Dio (Endpoint: /teste).

providers/: Lógica que controla a tela (Loading, Erros e Dados).

ui/: Interfaces (Screens) e componentes menores (Widgets).

📱 Funcionalidades
Listagem Responsiva: Os dados são exibidos em lista (Mobile) ou grade (Desktop/Web).

Criação: Formulário para adicionar novos usuários (Nome, CPF e Idade).

Edição: Alteração de dados de usuários já existentes.

Exclusão: Remoção de registros com atualização automática da interface.

🚀 Como Rodar
Clone este repositório.

No terminal, execute: flutter pub get.

Rode o projeto com: flutter run.
