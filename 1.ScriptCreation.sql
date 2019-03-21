SET LINESIZE 350;
SET SERVEROUTPUT ON;

create table BANQUE(
IdBanque int,
LibelleBanque VARCHAR(50) CONSTRAINT NN_Banque_Libelle NOT NULL,
CPBanque VARCHAR(5) CONSTRAINT NN_Banque_CPBanque NOT NULL,
AdresseBanque VARCHAR(50) CONSTRAINT NN_Banque_AdresseBanque NOT NULL,
VilleBanque VARCHAR(30) CONSTRAINT NN_Banque_VilleBanque NOT NULL 
)
/
ALTER TABLE BANQUE ADD CONSTRAINT PK_Banque_IdBanque PRIMARY KEY(IdBanque)
/
ALTER TABLE BANQUE ADD CONSTRAINT U_Banque_Libelle UNIQUE(LibelleBanque)
/



create table TYPECOMPTE(
IdTypeCompte int,
LibelleTypeCompte VARCHAR(30) CONSTRAINT NN_TypeCompte_LibTypeCompte NOT NULL
)
/
ALTER TABLE TYPECOMPTE ADD CONSTRAINT PK_TypeCompte_IdTypeCompte PRIMARY KEY(IdTypeCompte)
/


create table COMPTE(
IdCompte int,
LibelleCompte VARCHAR(30) CONSTRAINT NN_Compte_Libelle NOT NULL,
SoldeCompte NUMBER(10,2) DEFAULT '0' CONSTRAINT NN_Compte_SoldeCompte NOT NULL,
DecouvertAutorise NUMBER(10,2) DEFAULT '0' CONSTRAINT NN_Compte_DecouvertAutorise NOT NULL,
DateOuvertureCompte DATE DEFAULT SYSDATE CONSTRAINT NN_Compte_DateOuvertureCompte NOT NULL,
IdBanque int,
IdTypeCompte int
)
/
ALTER TABLE COMPTE ADD CONSTRAINT PK_Compte_IdCompte PRIMARY KEY(IdCompte)
/
ALTER TABLE COMPTE ADD CONSTRAINT U_Compte_LibelleCompte UNIQUE(LibelleCompte)
/
ALTER TABLE COMPTE ADD CONSTRAINT FK_Banque_IdBanque FOREIGN KEY (IdBanque) REFERENCES BANQUE(IdBanque)
/
ALTER TABLE COMPTE ADD CONSTRAINT FK_TypeCompte_IdTypeCompte FOREIGN KEY (IdTypeCompte) REFERENCES TYPECOMPTE(IdTypeCompte)
/

create table COMPTEWORK(
IdCompteWork int,
LibelleCompteWork VARCHAR(30),
SoldeCompteWork NUMBER(10,2) DEFAULT '0',
DecouvertAutoriseWork NUMBER(10,2) DEFAULT '0',
DateOuvertureCompteWork DATE DEFAULT SYSDATE
)
/

create table OPERATION(
IdOperation int,
DateOperation DATE CONSTRAINT NN_Operation_DateOperation NOT NULL,
MontantOperation NUMBER(10,2) CONSTRAINT NN_Operation_MontantOperation NOT NULL,
IdCompte int
)
/
ALTER TABLE OPERATION ADD CONSTRAINT PK_Operation_IdOperation PRIMARY KEY(IdOperation)
/
ALTER TABLE OPERATION ADD CONSTRAINT FK_Compte_IdCompte FOREIGN KEY (IdCompte) REFERENCES COMPTE(IdCompte)
/

create table OPERATIONWORK(
IdOperationWork int,
DateOperationWork DATE,
MontantOperationWork NUMBER(10,2)
)
/

create table AUDITDECOUVERT(
IdAudit int,
IdCompte int CONSTRAINT NN_AuditDecouvert_IdCompte NOT NULL,
LibelleCompte VARCHAR(30) CONSTRAINT NN_AuditDecouvert_LibCompte NOT NULL,
SoldeCompte NUMBER(10,2) CONSTRAINT NN_AuditDecouvert_SoldeCompte NOT NULL,
DecouvertAutorise NUMBER(10,2) CONSTRAINT NN_AuditDecouvert_DecAutorise NOT NULL,
Depassement NUMBER(10,2) CONSTRAINT NN_AuditDecouvert_Depassement NOT NULL,
IdDerniereOperation int CONSTRAINT NN_AuditDecouvert_IdDerniereOp NOT NULL
)
/
ALTER TABLE AUDITDECOUVERT ADD CONSTRAINT PK_AuditDecouvert_IdAudit PRIMARY KEY(IdAudit)
/