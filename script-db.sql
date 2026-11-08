-- ------------------------------------------------------------
-- BANCO DE DADOS: ATTENDIA
-- ------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS attendia
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE attendia;

-- ------------------------------------------------------------
-- 1. TABELA: CONDOMINIO
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS condomino (
    id_condominio INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    logo VARCHAR(255) NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    PRIMARY KEY (id_condominio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 2. TABELA: BLOCO
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bloco (
    id_bloco INT AUTO_INCREMENT,
    id_condominio INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_bloco),
    CONSTRAINT fk_bloco_condominio
        FOREIGN KEY (id_condominio)
        REFERENCES condomino(id_condominio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 3. TABELA: UNIDADE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS unidade (
    id_unidade INT AUTO_INCREMENT,
    id_bloco INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_unidade),
    CONSTRAINT fk_unidade_bloco
        FOREIGN KEY (id_bloco)
        REFERENCES bloco(id_bloco)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 4. TABELA: USUARIO
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NULL,
    avatar VARCHAR(255) NULL,
    PRIMARY KEY (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 5. TABELA: MORADOR
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS morador (
    id_morador INT AUTO_INCREMENT,
    id_unidade INT NOT NULL,
    id_usuario INT NOT NULL UNIQUE,
    PRIMARY KEY (id_morador),
    CONSTRAINT fk_morador_unidade
        FOREIGN KEY (id_unidade)
        REFERENCES unidade(id_unidade)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_morador_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 6. TABELA: VISITANTE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS visitante (
    id_visitante INT AUTO_INCREMENT,
    id_unidade INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NULL,
    avatar VARCHAR(255) NULL,
    PRIMARY KEY (id_visitante),
    CONSTRAINT fk_visitante_unidade
        FOREIGN KEY (id_unidade)
        REFERENCES unidade(id_unidade)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- CARGA INICIAL DE DADOS DE TESTE (SEED)
-- ------------------------------------------------------------

-- Inserir Condomínio
INSERT INTO condomino (nome, logo, rua, numero, bairro, cidade, estado) VALUES
('Condomínio Residenziale AttendIA', 'logo_attendia.png', 'Av. Central', '1000', 'Centro', 'São Paulo', 'SP');

-- Inserir Bloco
INSERT INTO bloco (id_condominio, nome) VALUES
(1, 'Bloco A'),
(1, 'Bloco B');

-- Inserir Unidades
INSERT INTO unidade (id_bloco, numero) VALUES
(1, '101'),
(1, '102'),
(2, '201');

-- Inserir Usuários
INSERT INTO usuario (nome, email, senha, telefone, avatar) VALUES
('Carlos Silva', 'carlos.silva@email.com', '$2y$10$e8Z...', '11999998888', 'carlos.png'),
('Maria Oliveira', 'maria.oliveira@email.com', '$2y$10$f9Y...', '11977776666', 'maria.png');

-- Inserir Morador
INSERT INTO morador (id_unidade, id_usuario) VALUES
(1, 1);

-- Inserir Visitante
INSERT INTO visitante (id_unidade, nome, telefone, avatar) VALUES
(1, 'João Pedro (Técnico)', '11955554444', 'joao.png');
