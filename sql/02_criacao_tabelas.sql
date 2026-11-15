-- ============================================================
-- SprintHub - Gestao de Projetos de Software
-- Arquivo: 02_criacao_tabelas.sql
-- SGBD: MySQL 8.4+
-- Engine: InnoDB | Charset: utf8mb4
-- ============================================================

USE sprinthub;

-- ------------------------------------------------------------
-- 1. CARGO
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cargo (
    id_cargo INT AUTO_INCREMENT,
    nome_cargo VARCHAR(80) NOT NULL,
    salario_minimo DECIMAL(10,2) NOT NULL,
    salario_maximo DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_cargo PRIMARY KEY (id_cargo),
    CONSTRAINT uq_cargo_nome UNIQUE (nome_cargo),
    CONSTRAINT chk_cargo_faixa_salarial
        CHECK (salario_maximo >= salario_minimo)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 2. CLIENTE
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT AUTO_INCREMENT,
    nome_cliente VARCHAR(120) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    email VARCHAR(120),
    telefone VARCHAR(20),

    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_cnpj UNIQUE (cnpj)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 3. FUNCIONARIO
-- RN01: cargo obrigatorio.
-- RN03: salario positivo; desligados permanecem cadastrados
--       com status D.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario INT AUTO_INCREMENT,
    nome_funcionario VARCHAR(120) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    status CHAR(1) NOT NULL DEFAULT 'A',
    id_cargo INT NOT NULL,

    CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario),
    CONSTRAINT chk_funcionario_salario
        CHECK (salario > 0),
    CONSTRAINT chk_funcionario_status
        CHECK (status IN ('A', 'D')),
    CONSTRAINT fk_funcionario_cargo
        FOREIGN KEY (id_cargo)
        REFERENCES cargo(id_cargo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 4. PROJETO
-- RN04: todo projeto possui um gerente que e funcionario.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS projeto (
    id_projeto INT AUTO_INCREMENT,
    nome_projeto VARCHAR(120) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'Planejado',
    id_gerente INT NOT NULL,

    CONSTRAINT pk_projeto PRIMARY KEY (id_projeto),
    CONSTRAINT chk_projeto_periodo
        CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    CONSTRAINT chk_projeto_status
        CHECK (status IN ('Planejado', 'Em andamento', 'Concluido', 'Cancelado')),
    CONSTRAINT fk_projeto_gerente
        FOREIGN KEY (id_gerente)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 5. CONTRATO
-- RN05: cada contrato pertence a um cliente e a um projeto.
-- UNIQUE(id_projeto) limita a um contrato por projeto.
-- A obrigatoriedade de todo projeto possuir contrato precisa
-- ser verificada/documentada separadamente.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS contrato (
    id_contrato INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_projeto INT NOT NULL,
    valor_contratado DECIMAL(12,2) NOT NULL,
    data_assinatura DATE NOT NULL,

    CONSTRAINT pk_contrato PRIMARY KEY (id_contrato),
    CONSTRAINT uq_contrato_projeto UNIQUE (id_projeto),
    CONSTRAINT chk_contrato_valor
        CHECK (valor_contratado > 0),
    CONSTRAINT fk_contrato_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_contrato_projeto
        FOREIGN KEY (id_projeto)
        REFERENCES projeto(id_projeto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 6. FUNCIONARIO_PROJETO
-- RN06: relacionamento N:N, com papel e carga semanal.
-- RN07: nao permite alocacoes duplicadas.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS funcionario_projeto (
    id_funcionario INT NOT NULL,
    id_projeto INT NOT NULL,
    papel VARCHAR(60) NOT NULL,
    carga_horaria_semanal TINYINT NOT NULL,

    CONSTRAINT pk_funcionario_projeto
        PRIMARY KEY (id_funcionario, id_projeto),
    CONSTRAINT chk_alocacao_carga_semanal
        CHECK (carga_horaria_semanal BETWEEN 1 AND 44),
    CONSTRAINT fk_funcionario_projeto_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_funcionario_projeto_projeto
        FOREIGN KEY (id_projeto)
        REFERENCES projeto(id_projeto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 7. SPRINT
-- RN08: numero unico dentro de cada projeto e data final
--       posterior a data inicial.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS sprint (
    id_sprint INT AUTO_INCREMENT,
    id_projeto INT NOT NULL,
    numero INT NOT NULL,
    nome_sprint VARCHAR(120) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,

    CONSTRAINT pk_sprint PRIMARY KEY (id_sprint),
    CONSTRAINT uq_sprint_projeto_numero UNIQUE (id_projeto, numero),
    CONSTRAINT chk_sprint_numero CHECK (numero > 0),
    CONSTRAINT chk_sprint_periodo CHECK (data_fim > data_inicio),
    CONSTRAINT fk_sprint_projeto
        FOREIGN KEY (id_projeto)
        REFERENCES projeto(id_projeto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 8. TAREFA
-- RN09: estimativa Fibonacci.
-- RN10: responsavel opcional; SET NULL preserva a tarefa.
-- Os dominios de tipo, prioridade e status foram definidos
-- explicitamente para esta implementacao.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS tarefa (
    id_tarefa INT AUTO_INCREMENT,
    id_sprint INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    tipo VARCHAR(20) NOT NULL,
    prioridade VARCHAR(20) NOT NULL,
    estimativa_story_points TINYINT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Aberta',
    id_responsavel INT,

    CONSTRAINT pk_tarefa PRIMARY KEY (id_tarefa),
    CONSTRAINT chk_tarefa_tipo
        CHECK (tipo IN ('Funcionalidade', 'Correcao', 'Melhoria', 'Debito tecnico')),
    CONSTRAINT chk_tarefa_prioridade
        CHECK (prioridade IN ('Baixa', 'Media', 'Alta', 'Critica')),
    CONSTRAINT chk_tarefa_estimativa
        CHECK (estimativa_story_points IN (1, 2, 3, 5, 8, 13)),
    CONSTRAINT chk_tarefa_status
        CHECK (status IN ('Aberta', 'Em andamento', 'Concluida', 'Cancelada')),
    CONSTRAINT fk_tarefa_sprint
        FOREIGN KEY (id_sprint)
        REFERENCES sprint(id_sprint)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_tarefa_responsavel
        FOREIGN KEY (id_responsavel)
        REFERENCES funcionario(id_funcionario)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- 9. APONTAMENTO_HORAS
-- RN11: entre 0,25 e 12 horas; no maximo um apontamento
--       por funcionario/tarefa/data.
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS apontamento_horas (
    id_apontamento INT AUTO_INCREMENT,
    id_funcionario INT NOT NULL,
    id_tarefa INT NOT NULL,
    data_apontamento DATE NOT NULL,
    quantidade_horas DECIMAL(4,2) NOT NULL,

    CONSTRAINT pk_apontamento_horas PRIMARY KEY (id_apontamento),
    CONSTRAINT uq_apontamento_funcionario_tarefa_data
        UNIQUE (id_funcionario, id_tarefa, data_apontamento),
    CONSTRAINT chk_apontamento_quantidade
        CHECK (quantidade_horas BETWEEN 0.25 AND 12.00),
    CONSTRAINT fk_apontamento_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_apontamento_tarefa
        FOREIGN KEY (id_tarefa)
        REFERENCES tarefa(id_tarefa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


-- ------------------------------------------------------------
-- FIM DO DDL
-- ------------------------------------------------------------
