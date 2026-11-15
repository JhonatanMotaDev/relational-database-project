-- SprintHub - Dados iniciais para demonstracao
-- Os dados sao ficticios e foram construidos para respeitar as FKs e CHECKs.
--

USE sprinthub;

START TRANSACTION;

-- ---------------------------------------------------------
-- 1. CARGOS (15 registros)
-- ---------------------------------------------------------
INSERT INTO cargo
    (id_cargo, nome_cargo, salario_minimo, salario_maximo)
VALUES
    (1,  'Desenvolvedor Junior',       2500.00, 4500.00),
    (2,  'Desenvolvedor Pleno',        4500.00, 7500.00),
    (3,  'Desenvolvedor Senior',       7500.00, 12000.00),
    (4,  'Analista de Testes',         3000.00, 6500.00),
    (5,  'Engenheiro de QA',           5000.00, 9000.00),
    (6,  'Product Owner',              6000.00, 11000.00),
    (7,  'Scrum Master',               5000.00, 9500.00),
    (8,  'Gerente de Projetos',        8000.00, 14000.00),
    (9,  'Analista de Dados',          4000.00, 8000.00),
    (10, 'Cientista de Dados',         6500.00, 13000.00),
    (11, 'Engenheiro de Dados',        6000.00, 11500.00),
    (12, 'UX Designer',                3500.00, 7500.00),
    (13, 'DevOps',                     5500.00, 10500.00),
    (14, 'Arquiteto de Software',      9000.00, 16000.00),
    (15, 'Analista de Suporte',        2500.00, 5000.00);

-- ---------------------------------------------------------
-- 2. CLIENTES (15 registros)
-- ---------------------------------------------------------
INSERT INTO cliente
    (id_cliente, nome_cliente, cnpj, email, telefone)
VALUES
    (1,  'Alfa Comercio Digital',       '12000000000001', 'contato@alfadigital.example',       '(38) 3000-0001'),
    (2,  'BioNorte Laboratorios',       '12000000000002', 'ti@bionorte.example',               '(38) 3000-0002'),
    (3,  'Cooperativa Horizonte',       '12000000000003', 'projetos@horizonte.example',        '(38) 3000-0003'),
    (4,  'Educare Sistemas',            '12000000000004', 'contato@educare.example',           '(38) 3000-0004'),
    (5,  'Financeira Vale',             '12000000000005', 'tecnologia@financeiravale.example','(38) 3000-0005'),
    (6,  'Grupo Minas Logistica',       '12000000000006', 'ti@minaslog.example',               '(38) 3000-0006'),
    (7,  'Hospital Santa Clara',        '12000000000007', 'inovacao@santaclara.example',       '(38) 3000-0007'),
    (8,  'Industria Serra Azul',        '12000000000008', 'sistemas@serraazul.example',       '(38) 3000-0008'),
    (9,  'Loja Central',                '12000000000009', 'digital@lojacentral.example',      '(38) 3000-0009'),
    (10, 'Mercado Bom Preco',           '12000000000010', 'ti@bompreco.example',               '(38) 3000-0010'),
    (11, 'Nexa Energia',                '12000000000011', 'projetos@nexaenergia.example',     '(38) 3000-0011'),
    (12, 'Prefeitura de Vale Verde',    '12000000000012', 'tecnologia@valeverde.example',     '(38) 3000-0012'),
    (13, 'Rede Aprender',               '12000000000013', 'contato@redeaprender.example',     '(38) 3000-0013'),
    (14, 'Saude Integrada',             '12000000000014', 'sistemas@saudeintegrada.example',  '(38) 3000-0014'),
    (15, 'Transporte Rota Sul',         '12000000000015', 'ti@rotasul.example',                '(38) 3000-0015');

-- ---------------------------------------------------------
-- 3. FUNCIONARIOS (20 registros)
-- ---------------------------------------------------------
INSERT INTO funcionario
    (id_funcionario, nome_funcionario, salario, status, id_cargo)
VALUES
    (1,  'Ana Martins',          10500.00, 'A', 8),
    (2,  'Bruno Almeida',         6500.00, 'A', 2),
    (3,  'Carla Ribeiro',        11000.00, 'A', 8),
    (4,  'Diego Santos',          5200.00, 'A', 4),
    (5,  'Eduarda Costa',         9800.00, 'A', 8),
    (6,  'Felipe Rocha',          7000.00, 'A', 2),
    (7,  'Gabriela Lima',        11500.00, 'A', 8),
    (8,  'Heitor Nunes',          6000.00, 'A', 11),
    (9,  'Isabela Freitas',       9000.00, 'A', 8),
    (10, 'Joao Pedro Souza',      4200.00, 'A', 1),
    (11, 'Larissa Mendes',       10000.00, 'A', 8),
    (12, 'Marcos Vieira',         7200.00, 'A', 9),
    (13, 'Natalia Ferreira',      8500.00, 'A', 8),
    (14, 'Otavio Carvalho',       5800.00, 'A', 5),
    (15, 'Paula Azevedo',        12000.00, 'A', 8),
    (16, 'Rafael Gomes',          6800.00, 'A', 13),
    (17, 'Sofia Barros',          7400.00, 'A', 12),
    (18, 'Thiago Oliveira',       8000.00, 'A', 3),
    (19, 'Vanessa Cardoso',       6500.00, 'D', 6),
    (20, 'William Teixeira',      3800.00, 'A', 15);

-- ---------------------------------------------------------
-- 4. PROJETOS (15 registros)
-- Cada projeto possui um gerente que ja existe em funcionario.
-- ---------------------------------------------------------
INSERT INTO projeto
    (id_projeto, nome_projeto, descricao, data_inicio, data_fim, status, id_gerente)
VALUES
    (1,  'Portal de Vendas',          'Portal web para vendas e acompanhamento de pedidos.',       '2026-01-05', NULL, 'Em andamento', 1),
    (2,  'Sistema BioLab',            'Gestao de exames e resultados laboratoriais.',                '2026-01-12', NULL, 'Em andamento', 3),
    (3,  'Cooperativa Digital',       'Plataforma de associados e operacoes financeiras.',          '2026-02-02', NULL, 'Em andamento', 5),
    (4,  'Educare EAD',               'Ambiente virtual de aprendizagem.',                           '2026-02-09', NULL, 'Em andamento', 7),
    (5,  'Credito Facil',             'Esteira digital de solicitacao e analise de credito.',       '2026-02-16', NULL, 'Em andamento', 9),
    (6,  'Minas Tracking',            'Rastreamento de cargas e gestao de entregas.',                '2026-03-02', NULL, 'Em andamento', 11),
    (7,  'Prontuario Integrado',      'Sistema de prontuario eletronico.',                           '2026-03-09', NULL, 'Em andamento', 13),
    (8,  'Serra ERP',                 'Modernizacao de modulos de ERP industrial.',                   '2026-03-16', NULL, 'Em andamento', 15),
    (9,  'Central Omnichannel',       'Integracao de canais de atendimento e vendas.',               '2026-04-01', NULL, 'Planejado', 1),
    (10, 'BomPreco Analytics',        'Painel de indicadores comerciais.',                           '2026-04-06', NULL, 'Em andamento', 3),
    (11, 'Nexa Monitoramento',        'Monitoramento de ativos de energia.',                          '2026-04-13', NULL, 'Em andamento', 5),
    (12, 'Vale Verde Digital',        'Digitalizacao de servicos municipais.',                        '2026-04-20', NULL, 'Planejado', 7),
    (13, 'Rede Aprender App',         'Aplicativo de comunicacao escolar.',                           '2026-05-04', NULL, 'Em andamento', 9),
    (14, 'Saude Integrada',           'Agendamento e acompanhamento de pacientes.',                  '2026-05-11', NULL, 'Em andamento', 11),
    (15, 'Rota Sul Operacoes',        'Planejamento de rotas e controle de frota.',                   '2026-05-18', NULL, 'Planejado', 13);

-- ---------------------------------------------------------
-- 5. CONTRATOS (15 registros)
-- Um contrato para cada projeto e um cliente por contrato.
-- ---------------------------------------------------------
INSERT INTO contrato
    (id_contrato, id_cliente, id_projeto, valor_contratado, data_assinatura)
VALUES
    (1, 1,  1,  85000.00, '2025-12-15'),
    (2, 2,  2, 120000.00, '2025-12-20'),
    (3, 3,  3,  95000.00, '2026-01-10'),
    (4, 4,  4, 110000.00, '2026-01-15'),
    (5, 5,  5, 135000.00, '2026-01-20'),
    (6, 6,  6,  98000.00, '2026-02-01'),
    (7, 7,  7, 150000.00, '2026-02-05'),
    (8, 8,  8, 175000.00, '2026-02-10'),
    (9, 9,  9,  70000.00, '2026-02-15'),
    (10, 10, 10, 90000.00, '2026-02-20'),
    (11, 11, 11, 125000.00, '2026-03-01'),
    (12, 12, 12, 105000.00, '2026-03-05'),
    (13, 13, 13,  80000.00, '2026-03-10'),
    (14, 14, 14, 140000.00, '2026-03-15'),
    (15, 15, 15, 115000.00, '2026-03-20');

-- ---------------------------------------------------------
-- 6. ALOCACOES FUNCIONARIO-PROJETO (30 registros)
-- Duas alocacoes por projeto. O funcionario 20 fica sem projeto.
-- ---------------------------------------------------------
INSERT INTO funcionario_projeto
    (id_funcionario, id_projeto, papel, carga_horaria_semanal)
VALUES
    (1, 1,  'Gerente de projeto',       20.00),
    (2, 1,  'Desenvolvedor',            40.00),
    (3, 2,  'Gerente de projeto',       20.00),
    (4, 2,  'Analista de testes',       40.00),
    (5, 3,  'Gerente de projeto',       20.00),
    (6, 3,  'Desenvolvedor',            40.00),
    (7, 4,  'Gerente de projeto',       20.00),
    (8, 4,  'Engenheiro de dados',      40.00),
    (9, 5,  'Gerente de projeto',       20.00),
    (10, 5, 'Desenvolvedor',            40.00),
    (11, 6, 'Gerente de projeto',       20.00),
    (12, 6, 'Analista de dados',        40.00),
    (13, 7, 'Gerente de projeto',       20.00),
    (14, 7, 'Engenheiro de QA',         40.00),
    (15, 8, 'Gerente de projeto',       20.00),
    (16, 8, 'DevOps',                   40.00),
    (1, 9,  'Gerente de projeto',       20.00),
    (17, 9, 'UX Designer',              40.00),
    (3, 10, 'Gerente de projeto',       20.00),
    (12, 10, 'Analista de dados',       40.00),
    (5, 11, 'Gerente de projeto',       20.00),
    (16, 11, 'DevOps',                  40.00),
    (7, 12, 'Gerente de projeto',       20.00),
    (18, 12, 'Desenvolvedor senior',    40.00),
    (9, 13, 'Gerente de projeto',       20.00),
    (2, 13, 'Desenvolvedor',            40.00),
    (11, 14, 'Gerente de projeto',      20.00),
    (4, 14, 'Analista de testes',       40.00),
    (13, 15, 'Gerente de projeto',      20.00),
    (6, 15, 'Desenvolvedor',            40.00);

-- ---------------------------------------------------------
-- 7. SPRINTS (30 registros; duas por projeto)
-- ---------------------------------------------------------
INSERT INTO sprint
    (id_sprint, id_projeto, numero, nome_sprint, data_inicio, data_fim)
VALUES
    (1, 1, 1, 'Planejamento e base',       '2026-01-05', '2026-01-16'),
    (2, 1, 2, 'Funcionalidades iniciais',  '2026-01-19', '2026-01-30'),
    (3, 2, 1, 'Cadastro laboratorial',     '2026-01-12', '2026-01-23'),
    (4, 2, 2, 'Resultados e relatorios',   '2026-01-26', '2026-02-06'),
    (5, 3, 1, 'Estrutura da plataforma',   '2026-02-02', '2026-02-13'),
    (6, 3, 2, 'Operacoes de associados',   '2026-02-16', '2026-02-27'),
    (7, 4, 1, 'Ambiente de cursos',        '2026-02-09', '2026-02-20'),
    (8, 4, 2, 'Aulas e avaliacoes',         '2026-02-23', '2026-03-06'),
    (9, 5, 1, 'Solicitacao de credito',    '2026-02-16', '2026-02-27'),
    (10, 5, 2, 'Analise de propostas',     '2026-03-02', '2026-03-13'),
    (11, 6, 1, 'Rastreamento',             '2026-03-02', '2026-03-13'),
    (12, 6, 2, 'Gestao de entregas',       '2026-03-16', '2026-03-27'),
    (13, 7, 1, 'Cadastro de pacientes',    '2026-03-09', '2026-03-20'),
    (14, 7, 2, 'Prontuario e historico',   '2026-03-23', '2026-04-03'),
    (15, 8, 1, 'Mapeamento do ERP',        '2026-03-16', '2026-03-27'),
    (16, 8, 2, 'Integracao industrial',    '2026-03-30', '2026-04-10'),
    (17, 9, 1, 'Integracao de canais',     '2026-04-01', '2026-04-12'),
    (18, 9, 2, 'Jornada do cliente',       '2026-04-13', '2026-04-24'),
    (19, 10, 1, 'Coleta de indicadores',  '2026-04-06', '2026-04-17'),
    (20, 10, 2, 'Painel analitico',        '2026-04-20', '2026-05-01'),
    (21, 11, 1, 'Telemetria',              '2026-04-13', '2026-04-24'),
    (22, 11, 2, 'Alertas operacionais',    '2026-04-27', '2026-05-08'),
    (23, 12, 1, 'Servicos digitais',       '2026-04-20', '2026-05-01'),
    (24, 12, 2, 'Portal do cidadao',       '2026-05-04', '2026-05-15'),
    (25, 13, 1, 'Aplicativo escolar',      '2026-05-04', '2026-05-15'),
    (26, 13, 2, 'Comunicacao e avisos',    '2026-05-18', '2026-05-29'),
    (27, 14, 1, 'Agendamento',             '2026-05-11', '2026-05-22'),
    (28, 14, 2, 'Acompanhamento',          '2026-05-25', '2026-06-05'),
    (29, 15, 1, 'Planejamento de rotas',   '2026-05-18', '2026-05-29'),
    (30, 15, 2, 'Controle de frota',       '2026-06-01', '2026-06-12');

-- ---------------------------------------------------------
-- 8. TAREFAS (30 registros; uma por sprint)
-- Responsaveis estao alocados ao projeto da respectiva sprint.
-- ---------------------------------------------------------
INSERT INTO tarefa
    (id_tarefa, id_sprint, titulo, descricao, tipo, prioridade,
     estimativa_story_points, status, id_responsavel)
VALUES
    (1, 1, 'Configurar estrutura do portal', 'Preparar a estrutura inicial da aplicacao.', 'Funcionalidade', 'Alta', 5, 'Concluida', 2),
    (2, 2, 'Implementar catalogo de produtos', 'Disponibilizar consulta ao catalogo.', 'Funcionalidade', 'Alta', 8, 'Em andamento', 2),
    (3, 3, 'Criar cadastro de exames', 'Implementar cadastro dos exames laboratoriais.', 'Funcionalidade', 'Alta', 5, 'Concluida', 4),
    (4, 4, 'Gerar relatorio de resultados', 'Disponibilizar relatorios de resultados.', 'Funcionalidade', 'Media', 8, 'Aberta', 4),
    (5, 5, 'Modelar cadastro de associados', 'Criar estrutura de dados dos associados.', 'Funcionalidade', 'Media', 3, 'Concluida', 6),
    (6, 6, 'Corrigir calculo de saldo', 'Ajustar divergencia no calculo de saldo.', 'Correcao', 'Critica', 5, 'Aberta', 6),
    (7, 7, 'Implementar matriculas', 'Permitir matricula de estudantes em cursos.', 'Funcionalidade', 'Alta', 8, 'Em andamento', 8),
    (8, 8, 'Revisar fluxo de avaliacao', 'Revisar fluxo de envio de avaliacoes.', 'Melhoria', 'Media', 3, 'Aberta', 8),
    (9, 9, 'Criar formulario de credito', 'Implementar formulario de solicitacao.', 'Funcionalidade', 'Alta', 5, 'Concluida', 10),
    (10, 10, 'Validar regras de credito', 'Aplicar validacoes nas propostas.', 'Funcionalidade', 'Critica', 13, 'Aberta', 10),
    (11, 11, 'Integrar localizacao de cargas', 'Receber atualizacoes de localizacao.', 'Funcionalidade', 'Alta', 8, 'Em andamento', 12),
    (12, 12, 'Otimizar consulta de entregas', 'Melhorar o desempenho das consultas.', 'Melhoria', 'Media', 5, 'Aberta', 12),
    (13, 13, 'Criar cadastro de pacientes', 'Implementar cadastro de pacientes.', 'Funcionalidade', 'Alta', 8, 'Concluida', 14),
    (14, 14, 'Corrigir permissao de prontuario', 'Ajustar controle de acesso ao prontuario.', 'Correcao', 'Critica', 3, 'Aberta', 14),
    (15, 15, 'Mapear modulos do ERP', 'Documentar os modulos existentes.', 'Debito tecnico', 'Media', 5, 'Concluida', 16),
    (16, 16, 'Integrar modulo de estoque', 'Integrar movimentacoes de estoque.', 'Funcionalidade', 'Alta', 13, 'Em andamento', 16),
    (17, 17, 'Conectar canais de atendimento', 'Integrar os canais digitais.', 'Funcionalidade', 'Alta', 8, 'Aberta', 17),
    (18, 18, 'Aprimorar busca de clientes', 'Melhorar a busca no historico de clientes.', 'Melhoria', 'Baixa', 3, 'Aberta', 17),
    (19, 19, 'Preparar base de indicadores', 'Organizar os dados para analise.', 'Funcionalidade', 'Media', 5, 'Concluida', 12),
    (20, 20, 'Construir painel de vendas', 'Exibir indicadores comerciais.', 'Funcionalidade', 'Alta', 8, 'Em andamento', 12),
    (21, 21, 'Coletar telemetria', 'Implementar coleta de dados dos ativos.', 'Funcionalidade', 'Alta', 8, 'Aberta', 16),
    (22, 22, 'Configurar alertas de consumo', 'Criar alertas para limites operacionais.', 'Funcionalidade', 'Critica', 5, 'Aberta', 16),
    (23, 23, 'Catalogar servicos municipais', 'Organizar catalogo de servicos.', 'Funcionalidade', 'Media', 5, 'Em andamento', 18),
    (24, 24, 'Implementar solicitacao online', 'Permitir solicitacoes pelo portal.', 'Funcionalidade', 'Alta', 13, 'Aberta', 18),
    (25, 25, 'Criar tela inicial do aplicativo', 'Desenvolver a tela inicial.', 'Funcionalidade', 'Media', 5, 'Concluida', 2),
    (26, 26, 'Enviar avisos escolares', 'Implementar envio de comunicados.', 'Funcionalidade', 'Alta', 8, 'Aberta', 2),
    (27, 27, 'Implementar agenda de consultas', 'Permitir agendamento de consultas.', 'Funcionalidade', 'Alta', 8, 'Em andamento', 4),
    (28, 28, 'Revisar historico do paciente', 'Aprimorar visualizacao do historico.', 'Melhoria', 'Media', 5, 'Aberta', 4),
    (29, 29, 'Calcular rotas de entrega', 'Implementar calculo de rotas.', 'Funcionalidade', 'Critica', 13, 'Aberta', 6),
    (30, 30, 'Corrigir atualizacao da frota', 'Corrigir atualizacao de disponibilidade.', 'Correcao', 'Alta', 3, 'Aberta', 6);

-- ---------------------------------------------------------
-- 9. APONTAMENTOS DE HORAS (30 registros)
-- Cada autor esta alocado ao projeto da tarefa correspondente.
-- Nao ha duplicidade de funcionario/tarefa/data.
-- ---------------------------------------------------------
INSERT INTO apontamento_horas
    (id_apontamento, id_funcionario, id_tarefa, data_apontamento, quantidade_horas)
VALUES
    (1,  2,  1, '2026-01-08', 4.00),
    (2,  2,  2, '2026-01-22', 3.50),
    (3,  4,  3, '2026-01-15', 5.00),
    (4,  4,  4, '2026-01-29', 2.00),
    (5,  6,  5, '2026-02-05', 4.00),
    (6,  6,  6, '2026-02-19', 3.00),
    (7,  8,  7, '2026-02-12', 6.00),
    (8,  8,  8, '2026-02-26', 2.50),
    (9,  10, 9, '2026-02-19', 4.00),
    (10, 10, 10,'2026-03-05', 5.00),
    (11, 12, 11,'2026-03-05', 4.50),
    (12, 12, 12,'2026-03-19', 3.00),
    (13, 14, 13,'2026-03-12', 5.00),
    (14, 14, 14,'2026-03-26', 2.00),
    (15, 16, 15,'2026-03-19', 4.00),
    (16, 16, 16,'2026-04-02', 6.00),
    (17, 17, 17,'2026-04-04', 3.50),
    (18, 17, 18,'2026-04-16', 2.00),
    (19, 12, 19,'2026-04-09', 4.00),
    (20, 12, 20,'2026-04-23', 5.50),
    (21, 16, 21,'2026-04-16', 4.00),
    (22, 16, 22,'2026-04-30', 3.00),
    (23, 18, 23,'2026-04-23', 4.50),
    (24, 18, 24,'2026-05-07', 5.00),
    (25, 2,  25,'2026-05-07', 4.00),
    (26, 2,  26,'2026-05-21', 3.50),
    (27, 4,  27,'2026-05-14', 4.00),
    (28, 4,  28,'2026-05-28', 2.50),
    (29, 6,  29,'2026-05-21', 5.00),
    (30, 6,  30,'2026-06-04', 3.00);

COMMIT;

-- ---------------------------------------------------------
-- VALIDACAO: deve retornar 15+ para cada tabela.
-- Execute este bloco apos o COMMIT para conferir as contagens.
-- ---------------------------------------------------------
SELECT 'cargo' AS tabela, COUNT(*) AS total FROM cargo
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'funcionario', COUNT(*) FROM funcionario
UNION ALL SELECT 'projeto', COUNT(*) FROM projeto
UNION ALL SELECT 'contrato', COUNT(*) FROM contrato
UNION ALL SELECT 'funcionario_projeto', COUNT(*) FROM funcionario_projeto
UNION ALL SELECT 'sprint', COUNT(*) FROM sprint
UNION ALL SELECT 'tarefa', COUNT(*) FROM tarefa
UNION ALL SELECT 'apontamento_horas', COUNT(*) FROM apontamento_horas
ORDER BY tabela;
