
-- =========================================================
-- SprintHub - Consultas SQL
-- MySQL Community Server 8.4.9
-- Banco de dados: sprinthub
-- =========================================================
--
-- Q01 a Q05 e Q13 a Q14: Consultas simples
-- Q06 a Q10: Consultas com JOIN
-- Q11 e Q12: Consultas adicionais
-- Q15: Consulta com subconsulta
--
-- As consultas são somente leitura e não alteram os dados.
-- =========================================================

USE sprinthub;


-- =========================================================
-- CONSULTAS SIMPLES
-- =========================================================

-- Q01. Funcionários ativos
-- Quais funcionários estão atualmente ativos?

SELECT
    id_funcionario,
    nome_funcionario,
    salario,
    status
FROM funcionario
WHERE status = 'A'
ORDER BY nome_funcionario;


-- Q02. Projetos em andamento
-- Quais projetos estão atualmente em execução?

SELECT
    id_projeto,
    nome_projeto,
    data_inicio,
    status
FROM projeto
WHERE status = 'Em andamento'
ORDER BY data_inicio;


-- Q03. Contratos dentro de uma faixa de valores
-- Quais contratos possuem valor entre R$ 80.000 e R$ 130.000?

SELECT
    id_contrato,
    id_cliente,
    id_projeto,
    valor_contratado,
    data_assinatura
FROM contrato
WHERE valor_contratado BETWEEN 80000 AND 130000
ORDER BY valor_contratado DESC;


-- Q04. Tarefas críticas em aberto
-- Quais tarefas possuem prioridade crítica e ainda não foram concluídas?

SELECT
    id_tarefa,
    titulo,
    prioridade,
    status,
    estimativa_story_points
FROM tarefa
WHERE prioridade = 'Critica'
  AND status IN ('Aberta', 'Em andamento')
ORDER BY estimativa_story_points DESC;


-- Q05. Papéis existentes nas alocações
-- Quais são os diferentes papéis exercidos nos projetos?

SELECT DISTINCT
    papel
FROM funcionario_projeto
ORDER BY papel;


-- =========================================================
-- CONSULTAS COM JOIN
-- =========================================================

-- Q06. Funcionários alocados em projetos
-- Quais funcionários trabalham em cada projeto?
-- Relaciona: funcionario, funcionario_projeto e projeto.

SELECT
    f.nome_funcionario,
    p.nome_projeto,
    fp.papel,
    fp.carga_horaria_semanal
FROM funcionario AS f
INNER JOIN funcionario_projeto AS fp
    ON fp.id_funcionario = f.id_funcionario
INNER JOIN projeto AS p
    ON p.id_projeto = fp.id_projeto
ORDER BY p.nome_projeto, f.nome_funcionario;


-- Q07. Total de horas apontadas por projeto
-- Quantas horas foram registradas em cada projeto?
-- Relaciona quatro tabelas.
-- Utiliza SUM, COUNT, AVG, MAX, MIN, GROUP BY e HAVING.

SELECT
    p.id_projeto,
    p.nome_projeto,
    ROUND(SUM(ah.quantidade_horas), 2) AS total_horas,
    COUNT(ah.id_apontamento) AS quantidade_apontamentos,
    ROUND(AVG(ah.quantidade_horas), 2) AS media_horas,
    MAX(ah.quantidade_horas) AS maior_apontamento,
    MIN(ah.quantidade_horas) AS menor_apontamento
FROM projeto AS p
INNER JOIN sprint AS s
    ON s.id_projeto = p.id_projeto
INNER JOIN tarefa AS t
    ON t.id_sprint = s.id_sprint
INNER JOIN apontamento_horas AS ah
    ON ah.id_tarefa = t.id_tarefa
GROUP BY
    p.id_projeto,
    p.nome_projeto
HAVING SUM(ah.quantidade_horas) > 0
ORDER BY total_horas DESC;


-- Q08. Valores contratados por cliente
-- Quanto cada cliente contratou?
-- Relaciona cliente e contrato.
-- Utiliza COUNT, SUM, AVG, GROUP BY e HAVING.

SELECT
    c.id_cliente,
    c.nome_cliente,
    COUNT(ct.id_contrato) AS quantidade_contratos,
    ROUND(SUM(ct.valor_contratado), 2) AS total_contratado,
    ROUND(AVG(ct.valor_contratado), 2) AS valor_medio
FROM cliente AS c
INNER JOIN contrato AS ct
    ON ct.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente
HAVING SUM(ct.valor_contratado) >= 80000
ORDER BY total_contratado DESC;


-- Q09. Tarefas críticas por projeto
-- Em quais projetos estão as tarefas críticas ainda abertas?
-- Relaciona tarefa, sprint e projeto.

SELECT
    p.nome_projeto,
    s.numero,
    s.nome_sprint,
    t.id_tarefa,
    t.titulo,
    t.prioridade,
    t.status
FROM tarefa AS t
INNER JOIN sprint AS s
    ON s.id_sprint = t.id_sprint
INNER JOIN projeto AS p
    ON p.id_projeto = s.id_projeto
WHERE t.prioridade = 'Critica'
  AND t.status IN ('Aberta', 'Em andamento')
ORDER BY p.nome_projeto, s.numero;


-- Q10. Indicadores de tarefas por projeto
-- Quantas tarefas existem em cada projeto e qual a estimativa média?
-- Relaciona projeto, sprint e tarefa.
-- Utiliza COUNT, AVG, MAX, MIN, GROUP BY e HAVING.

SELECT
    p.id_projeto,
    p.nome_projeto,
    COUNT(t.id_tarefa) AS quantidade_tarefas,
    ROUND(AVG(t.estimativa_story_points), 2) AS media_estimativa,
    MAX(t.estimativa_story_points) AS maior_estimativa,
    MIN(t.estimativa_story_points) AS menor_estimativa
FROM projeto AS p
INNER JOIN sprint AS s
    ON s.id_projeto = p.id_projeto
INNER JOIN tarefa AS t
    ON t.id_sprint = s.id_sprint
GROUP BY
    p.id_projeto,
    p.nome_projeto
HAVING COUNT(t.id_tarefa) >= 1
ORDER BY media_estimativa DESC;


-- =========================================================
-- CONSULTAS ADICIONAIS
-- =========================================================

-- Q11. Funcionários sem alocação
-- Quais funcionários ainda não estão alocados em nenhum projeto?
-- Utiliza LEFT JOIN.

SELECT
    f.id_funcionario,
    f.nome_funcionario,
    f.status,
    c.nome_cargo
FROM funcionario AS f
INNER JOIN cargo AS c
    ON c.id_cargo = f.id_cargo
LEFT JOIN funcionario_projeto AS fp
    ON fp.id_funcionario = f.id_funcionario
WHERE fp.id_funcionario IS NULL
ORDER BY f.nome_funcionario;


-- Q12. Auditoria da regra de negócio RN12
-- Verifica se responsáveis de tarefas e autores de apontamentos
-- estão alocados ao projeto correspondente.
--
-- O resultado esperado é vazio: nenhuma incompatibilidade.
-- Esta consulta identifica violações, mas não impede inserções.

-- Verificação dos responsáveis das tarefas:

SELECT
    'Responsável sem alocação' AS tipo_inconsistencia,
    t.id_tarefa,
    f.id_funcionario,
    f.nome_funcionario,
    p.id_projeto,
    p.nome_projeto
FROM tarefa AS t
INNER JOIN sprint AS s
    ON s.id_sprint = t.id_sprint
INNER JOIN projeto AS p
    ON p.id_projeto = s.id_projeto
INNER JOIN funcionario AS f
    ON f.id_funcionario = t.id_responsavel
LEFT JOIN funcionario_projeto AS fp
    ON fp.id_funcionario = f.id_funcionario
   AND fp.id_projeto = p.id_projeto
WHERE fp.id_funcionario IS NULL

UNION ALL

-- Verificação dos autores dos apontamentos:

SELECT
    'Autor sem alocação' AS tipo_inconsistencia,
    t.id_tarefa,
    f.id_funcionario,
    f.nome_funcionario,
    p.id_projeto,
    p.nome_projeto
FROM apontamento_horas AS ah
INNER JOIN tarefa AS t
    ON t.id_tarefa = ah.id_tarefa
INNER JOIN sprint AS s
    ON s.id_sprint = t.id_sprint
INNER JOIN projeto AS p
    ON p.id_projeto = s.id_projeto
INNER JOIN funcionario AS f
    ON f.id_funcionario = ah.id_funcionario
LEFT JOIN funcionario_projeto AS fp
    ON fp.id_funcionario = f.id_funcionario
   AND fp.id_projeto = p.id_projeto
WHERE fp.id_funcionario IS NULL

ORDER BY tipo_inconsistencia, id_tarefa;


-- =========================================================
-- CONSULTAS SIMPLES COMPLEMENTARES E SUBCONSULTA
-- =========================================================

-- Q13. Buscar tarefas pelo título
-- Quais tarefas possuem a palavra "Criar" no título?
-- Demonstra o uso de LIKE.

SELECT
    id_tarefa,
    titulo,
    status,
    prioridade
FROM tarefa
WHERE titulo LIKE '%Criar%'
ORDER BY titulo;


-- Q14. Cinco contratos de maior valor
-- Quais são os cinco contratos de maior valor contratado?
-- Demonstra o uso de LIMIT com ordenação determinística.

SELECT
    id_contrato,
    id_projeto,
    valor_contratado,
    data_assinatura
FROM contrato
ORDER BY valor_contratado DESC, id_contrato ASC
LIMIT 5;


-- Q15. Contratos acima da média
-- Quais contratos têm valor superior à média de todos os contratos?
-- Demonstra o uso de uma subconsulta escalar.

SELECT
    ct.id_contrato,
    c.nome_cliente,
    p.nome_projeto,
    ct.valor_contratado
FROM contrato AS ct
INNER JOIN cliente AS c
    ON c.id_cliente = ct.id_cliente
INNER JOIN projeto AS p
    ON p.id_projeto = ct.id_projeto
WHERE ct.valor_contratado > (
    SELECT AVG(valor_contratado)
    FROM contrato
)
ORDER BY ct.valor_contratado DESC;
