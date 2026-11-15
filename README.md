# SprintHub: Gestão de Projetos de Software

Projeto acadêmico de banco de dados relacional para organizar clientes, contratos, projetos de software, equipes, sprints, tarefas e apontamentos de horas. O esquema foi implementado em SQL para MySQL 8.4 ou superior.

## Modelo

O banco `sprinthub` contém nove tabelas:

- `cargo` e `funcionario`: cargos e equipe;
- `cliente` e `contrato`: clientes e contratos associados a projetos;
- `projeto` e `funcionario_projeto`: projetos, gerentes e alocações de equipe;
- `sprint` e `tarefa`: planejamento e execução do trabalho;
- `apontamento_horas`: horas registradas por funcionário e tarefa.

O diagrama está em [der/SprinthubDiagrama.drawio.png](der/SprinthubDiagrama.drawio.png). As regras do modelo, a justificativa de normalização e o dicionário de dados estão na [documentação](docs/README.md).

## Requisitos

- MySQL 8.4 ou superior;
- cliente MySQL, como MySQL Shell ou MySQL Command-Line Client.

O projeto usa SQL/MySQL; não requer uma aplicação ou linguagem de programação adicional.

## Execução

Na raiz do projeto, abra o cliente MySQL:

```text
mysql -u root -p
```

No prompt do cliente, execute os scripts nesta ordem:

```sql
SOURCE sql/01_criacao_banco.sql;
SOURCE sql/02_criacao_tabelas.sql;
SOURCE sql/03_insercao_dados.sql;
SOURCE sql/04_consultas.sql;
```

O script de carga usa identificadores fixos e não foi feito para ser executado repetidamente sobre tabelas já populadas. Para uma nova execução, use uma instância/esquema de demonstração limpo e confirme o destino antes de remover qualquer dado.

## Consultas

O arquivo [sql/04_consultas.sql](sql/04_consultas.sql) contém 15 consultas comentadas: consultas simples, filtros, `JOIN`, agregações, `LEFT JOIN`, auditoria de alocação e uma subconsulta.

## Documentação

- [Índice da documentação](docs/README.md)
- [Relatório técnico](docs/relatorio-tecnico.md)
- [Dicionário de dados](docs/dicionario-de-dados.md)

## Equipe e publicação

- Integrantes: Jhonatan Pereira Mota e Ana Elisa Barbosa Cunha.
- Repositório público: adicionar o link após a publicação no GitHub.

Os dados de demonstração são fictícios.
