----------------------
--CRIACAO DE TABELAS--
----------------------


CREATE TABLE CCCOMPANY(
	CIPJ VARCHAR(4) PRIMARY KEY
);

CREATE TABLE CONTATOCOMPANY(
	CIPJCOMPANY VARCHAR(4),
	CONTATO VARCHAR(15),
	CONSTRAINT CONTATOC_PK PRIMARY KEY (CIPJCOMPANY, CONTATO),
	CONSTRAINT CONTATOC_FK FOREIGN KEY (CIPJCOMPANY) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE
);

CREATE TABLE FORNECEDOR(
	CIPJFORN VARCHAR(4),
	TIPO VARCHAR(10),
	CONSTRAINT FORN_PK PRIMARY KEY (CIPJFORN),
	CONSTRAINT FORN_FK FOREIGN KEY (CIPJFORN) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE
);

CREATE TABLE FABRICA(
	CIPJFAB VARCHAR(4),
	CONSTRAINT FAB_PK PRIMARY KEY (CIPJFAB),
	CONSTRAINT FAB_FK FOREIGN KEY (CIPJFAB) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE
);

CREATE TABLE MARKETING(
	CIPJMARK VARCHAR(4),
	CIPJMATRIZ VARCHAR(4),
	CONSTRAINT MARK_PK PRIMARY KEY (CIPJMARK),
	CONSTRAINT MARK_FK FOREIGN KEY (CIPJMARK) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE,
	CONSTRAINT MATRIZ_FK FOREIGN KEY (CIPJMATRIZ) REFERENCES MARKETING(CIPJMARK) ON DELETE CASCADE
);

CREATE TABLE DEPOSITO(
	CIPJDEP VARCHAR(4),
	CONSTRAINT DEP_PK PRIMARY KEY (CIPJDEP),
	CONSTRAINT DEP_FK FOREIGN KEY (CIPJDEP) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE
);

CREATE TABLE TRANSPORTADORA(
	CIPJTRANS VARCHAR(4),
	NOME VARCHAR(20),
	CONSTRAINT TRANS_PK PRIMARY KEY (CIPJTRANS),
	CONSTRAINT TRANS_FK FOREIGN KEY (CIPJTRANS) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE
);

CREATE TABLE CAMINHAOMOTORISTA(
	PLACA VARCHAR(5),
	CIPJTRANS VARCHAR(4) NOT NULL,
	CPFMOTOR VARCHAR(4) NOT NULL UNIQUE,
	CONSTRAINT CAMMOT_PK PRIMARY KEY (PLACA),
	CONSTRAINT CAMMOT_FK FOREIGN KEY (CIPJTRANS) REFERENCES CCCOMPANY(CIPJ) ON DELETE CASCADE
);

CREATE TABLE LOJA(
	CIPJLOJA VARCHAR(4) PRIMARY KEY,
	NOME VARCHAR(20),
	END_ESTADO VARCHAR(10),
	END_RUA VARCHAR(10),
	END_BAIRRO VARCHAR(10),
	END_NUMERO VARCHAR(10)
);

CREATE TABLE CONTATOLOJA(
	CIPJLOJA VARCHAR(4),
	CONTATO VARCHAR(15),
	CONSTRAINT CONTATOL_PK PRIMARY KEY (CIPJLOJA, CONTATO),
	CONSTRAINT CONTATOL_FK FOREIGN KEY (CIPJLOJA) REFERENCES LOJA(CIPJLOJA) ON DELETE CASCADE
);

CREATE TABLE CLIENTE(
	CPFCLI VARCHAR(4) PRIMARY KEY
);

CREATE TABLE COMPRA(
	CPFCLI VARCHAR(4),
	CIPJLOJA VARCHAR(4),
	CONSTRAINT COMPRA_PK PRIMARY KEY (CPFCLI, CIPJLOJA),
	CONSTRAINT COMPRA_FK1 FOREIGN KEY (CPFCLI) REFERENCES CLIENTE(CPFCLI) ON DELETE CASCADE,
	CONSTRAINT COMPRA_FK2 FOREIGN KEY (CIPJLOJA) REFERENCES LOJA(CIPJLOJA) ON DELETE CASCADE
);

CREATE TABLE ANUNCIO(
	CIPJMARK VARCHAR(4),
	ID NUMBER(4,0),
	DATA_AN DATE,
	TIPO VARCHAR(10),
	CONSTRAINT ANUNCIO_PK PRIMARY KEY (CIPJMARK, ID),
	CONSTRAINT ANUNCIO_FK FOREIGN KEY (CIPJMARK) REFERENCES MARKETING(CIPJMARK) ON DELETE CASCADE
);

CREATE TABLE DEPLOJA(
	CIPJLOJA VARCHAR(4),
	CIPJDEP VARCHAR(4),
	DATA_HORADL VARCHAR(15),
	CIPJTRANS VARCHAR(4),
	QTDDL NUMBER(9,0),
	VALOR_UNITDL NUMBER(9, 2),
	FRETEDL NUMBER(9,2),
	VALOR_TOTALDL NUMBER(9,2),
	CONSTRAINT DEPLOJA_PK PRIMARY KEY (CIPJLOJA, CIPJDEP, DATA_HORADL),
	CONSTRAINT DEPLOJA_FK1 FOREIGN KEY (CIPJLOJA) REFERENCES LOJA(CIPJLOJA) ON DELETE CASCADE, 
	CONSTRAINT DEPLOJA_FK2 FOREIGN KEY (CIPJDEP) REFERENCES DEPOSITO(CIPJDEP) ON DELETE CASCADE, 
	CONSTRAINT DEPLOJA_FK3 FOREIGN KEY (CIPJTRANS) REFERENCES TRANSPORTADORA(CIPJTRANS) ON DELETE CASCADE
);

CREATE TABLE FABFORN(
	CIPJFAB VARCHAR(4),
	CIPJFORN VARCHAR(4),
	DATA_HORAF VARCHAR(15),
	CIPJTRANS VARCHAR(4) NOT NULL,
	QTDF NUMBER(9,0),
	VALOR_UNITF NUMBER(9, 2),
	FRETEF NUMBER(9,2),
	VALOR_TOTALF NUMBER(9,2),
	CONSTRAINT FABFORN_PK PRIMARY KEY (CIPJFAB, CIPJFORN, DATA_HORAF),
	CONSTRAINT FABFORN_FK1 FOREIGN KEY (CIPJFAB) REFERENCES FABRICA(CIPJFAB) ON DELETE CASCADE, 
	CONSTRAINT FABFORN_FK2 FOREIGN KEY (CIPJFORN) REFERENCES FORNECEDOR(CIPJFORN) ON DELETE CASCADE, 
	CONSTRAINT FABFORN_FK3 FOREIGN KEY (CIPJTRANS) REFERENCES TRANSPORTADORA(CIPJTRANS) ON DELETE CASCADE
);

CREATE TABLE FABDEP(
	CIPJFAB VARCHAR(4),
	CIPJDEP VARCHAR(4),
	DATA_HORAD VARCHAR(15),
	CIPJTRANS VARCHAR(4) NOT NULL,
	QTDD NUMBER(9,0),
	VALOR_UNITD NUMBER(9, 2),
	FRETED NUMBER(9,2),
	VALOR_TOTALD NUMBER(9,2),
	CONSTRAINT FABDEP_PK PRIMARY KEY (CIPJFAB, CIPJDEP, DATA_HORAD),
	CONSTRAINT FABDEP_FK1 FOREIGN KEY (CIPJFAB) REFERENCES FABRICA(CIPJFAB) ON DELETE CASCADE, 
	CONSTRAINT FABDEP_FK2 FOREIGN KEY (CIPJDEP) REFERENCES DEPOSITO(CIPJDEP) ON DELETE CASCADE, 
	CONSTRAINT FABDEP_FK3 FOREIGN KEY (CIPJTRANS) REFERENCES TRANSPORTADORA(CIPJTRANS) ON DELETE CASCADE
);
