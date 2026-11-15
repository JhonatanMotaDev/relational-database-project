# Dicionário de dados

Este documento descreve as tabelas e colunas implementadas no esquema `sprinthub`. Tipos, nulabilidade e restrições abaixo refletem o DDL atual em [`sql/02_criacao_tabelas.sql`](../sql/02_criacao_tabelas.sql).

## `cargo`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_cargo` | `INT AUTO_INCREMENT` | Não | PK | Identificador do cargo. |
| `nome_cargo` | `VARCHAR(80)` | Não | UNIQUE | Nome do cargo. |
| `salario_minimo` | `DECIMAL(10,2)` | Não | — | Limite inferior da faixa salarial cadastrada. |
| `salario_maximo` | `DECIMAL(10,2)` | Não | CHECK `salario_maximo >= salario_minimo` | Limite superior da faixa salarial. |

## `cliente`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_cliente` | `INT AUTO_INCREMENT` | Não | PK | Identificador do cliente. |
| `nome_cliente` | `VARCHAR(120)` | Não | — | Nome ou razão social do cliente. |
| `cnpj` | `CHAR(14)` | Não | UNIQUE | CNPJ armazenado sem máscara. |
| `email` | `VARCHAR(120)` | Sim | — | E-mail de contato. |
| `telefone` | `VARCHAR(20)` | Sim | — | Telefone de contato. |

## `funcionario`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_funcionario` | `INT AUTO_INCREMENT` | Não | PK | Identificador do funcionário. |
| `nome_funcionario` | `VARCHAR(120)` | Não | — | Nome do funcionário. |
| `salario` | `DECIMAL(10,2)` | Não | CHECK `salario > 0` | Salário atual. |
| `status` | `CHAR(1)` | Não | DEFAULT `'A'`; CHECK `A` ou `D` | Situação: ativo (`A`) ou desligado (`D`). |
| `id_cargo` | `INT` | Não | FK → `cargo.id_cargo`; DELETE RESTRICT; UPDATE CASCADE | Cargo do funcionário. |

## `projeto`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_projeto` | `INT AUTO_INCREMENT` | Não | PK | Identificador do projeto. |
| `nome_projeto` | `VARCHAR(120)` | Não | — | Nome do projeto. |
| `descricao` | `TEXT` | Sim | — | Descrição do escopo do projeto. |
| `data_inicio` | `DATE` | Não | — | Data de início. |
| `data_fim` | `DATE` | Sim | CHECK: nula ou igual/posterior a `data_inicio` | Data de encerramento, quando definida. |
| `status` | `VARCHAR(20)` | Não | DEFAULT `'Planejado'`; CHECK: `Planejado`, `Em andamento`, `Concluido` ou `Cancelado` | Situação atual do projeto. |
| `id_gerente` | `INT` | Não | FK → `funcionario.id_funcionario`; DELETE RESTRICT; UPDATE CASCADE | Funcionário responsável pela gerência. |

## `contrato`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_contrato` | `INT AUTO_INCREMENT` | Não | PK | Identificador do contrato. |
| `id_cliente` | `INT` | Não | FK → `cliente.id_cliente`; DELETE RESTRICT; UPDATE CASCADE | Cliente contratante. |
| `id_projeto` | `INT` | Não | UNIQUE; FK → `projeto.id_projeto`; DELETE CASCADE; UPDATE CASCADE | Projeto associado. A unicidade limita cada projeto a, no máximo, um contrato. |
| `valor_contratado` | `DECIMAL(12,2)` | Não | CHECK `valor_contratado > 0` | Valor do contrato. |
| `data_assinatura` | `DATE` | Não | — | Data de assinatura. |

## `funcionario_projeto`

Entidade associativa que representa a relação N:N entre funcionários e projetos.

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_funcionario` | `INT` | Não | PK composta; FK → `funcionario.id_funcionario`; DELETE RESTRICT; UPDATE CASCADE | Funcionário alocado. |
| `id_projeto` | `INT` | Não | PK composta; FK → `projeto.id_projeto`; DELETE CASCADE; UPDATE CASCADE | Projeto da alocação. |
| `papel` | `VARCHAR(60)` | Não | — | Papel exercido no projeto. |
| `carga_horaria_semanal` | `TINYINT` | Não | CHECK entre 1 e 44 | Horas semanais previstas para esta alocação. O limite é aplicado por alocação, não à soma de projetos por funcionário. |

## `sprint`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_sprint` | `INT AUTO_INCREMENT` | Não | PK | Identificador da sprint. |
| `id_projeto` | `INT` | Não | FK → `projeto.id_projeto`; DELETE CASCADE; UPDATE CASCADE | Projeto ao qual a sprint pertence. |
| `numero` | `INT` | Não | UNIQUE com `id_projeto`; CHECK `numero > 0` | Número da sprint dentro do projeto. |
| `nome_sprint` | `VARCHAR(120)` | Não | — | Nome da sprint. |
| `data_inicio` | `DATE` | Não | CHECK com `data_fim` | Início da sprint. |
| `data_fim` | `DATE` | Não | CHECK `data_fim > data_inicio` | Fim da sprint. |

## `tarefa`

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_tarefa` | `INT AUTO_INCREMENT` | Não | PK | Identificador da tarefa. |
| `id_sprint` | `INT` | Não | FK → `sprint.id_sprint`; DELETE CASCADE; UPDATE CASCADE | Sprint da tarefa. |
| `titulo` | `VARCHAR(150)` | Não | — | Título da tarefa. |
| `descricao` | `TEXT` | Sim | — | Detalhamento da tarefa. |
| `tipo` | `VARCHAR(20)` | Não | CHECK: `Funcionalidade`, `Correcao`, `Melhoria` ou `Debito tecnico` | Categoria da tarefa. |
| `prioridade` | `VARCHAR(20)` | Não | CHECK: `Baixa`, `Media`, `Alta` ou `Critica` | Prioridade da tarefa. |
| `estimativa_story_points` | `TINYINT` | Não | CHECK: 1, 2, 3, 5, 8 ou 13 | Estimativa em pontos de história. |
| `status` | `VARCHAR(20)` | Não | DEFAULT `'Aberta'`; CHECK: `Aberta`, `Em andamento`, `Concluida` ou `Cancelada` | Situação da tarefa. |
| `id_responsavel` | `INT` | Sim | FK → `funcionario.id_funcionario`; DELETE SET NULL; UPDATE CASCADE | Funcionário responsável, quando atribuído. |

## `apontamento_horas`

Entidade associativa entre funcionário e tarefa, com data e quantidade de horas. A regra UNIQUE permite no máximo um apontamento por funcionário, tarefa e data.

| Campo | Tipo | Nulo? | Chave/restrição | Descrição |
|---|---|---:|---|---|
| `id_apontamento` | `INT AUTO_INCREMENT` | Não | PK | Identificador do apontamento. |
| `id_funcionario` | `INT` | Não | FK → `funcionario.id_funcionario`; DELETE RESTRICT; UPDATE CASCADE | Autor do apontamento. |
| `id_tarefa` | `INT` | Não | FK → `tarefa.id_tarefa`; DELETE CASCADE; UPDATE CASCADE | Tarefa trabalhada. |
| `data_apontamento` | `DATE` | Não | UNIQUE com funcionário e tarefa | Dia do registro. |
| `quantidade_horas` | `DECIMAL(4,2)` | Não | CHECK entre 0,25 e 12,00 | Horas registradas no dia. |

## Observações sobre integridade

- As FKs garantem que os registros relacionados existam, mas a associação de gerente, responsável ou autor de apontamento ao projeto não é imposta por uma FK composta. A consulta Q12 em [`sql/04_consultas.sql`](../sql/04_consultas.sql) audita essa regra após a inserção.
- A faixa salarial do cargo não é validada contra o salário individual do funcionário pelo DDL atual.
