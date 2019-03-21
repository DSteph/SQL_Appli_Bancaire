create or replace procedure AJOUTNOUVELOPERATION(UserIdCompte int, valeur number)
is
begin
	INSERT INTO Operation (IdOperation, DateOperation, MontantOperation, IdCompte)
	VALUES (CompteurOperation.NextVal, SYSDATE, valeur, UserIdCompte);
	end AJOUTNOUVELOPERATION;
/
show err

create or replace procedure ANNULEROPERATION(UserIdOperation int)
is 
	AncienMontant number(10,4);
	AncienIdCompte int;
begin
	SELECT MontantOperation, IdCompte into AncienMontant, AncienIdCompte FROM Operation WHERE IdOperation = UserIdOperation;
	AJOUTNOUVELOPERATION(AncienIdCompte, -AncienMontant);
	end ANNULEROPERATION;
/

show err

create or replace procedure MAJDECOUVERTAUTORISE(UserIdCompte int, valeur number)
is 
	IdC int;
	SolC NUMBER;
	DecAut NUMBER;
begin
	UPDATE COMPTE Set DecouvertAutorise = valeur WHERE IdCompte = UserIdCompte;
	UPDATE AUDITDECOUVERT SET DecouvertAutorise = valeur WHERE IdCompte = UserIdCompte;
	
	SELECT IdCompte, SoldeCompte, DecouvertAutorise into IdC, SolC, DecAut FROM COMPTE WHERE IdCompte = UserIdCompte;
	
	IF (SolC > DecAut)
	THEN
		DELETE FROM AUDITDECOUVERT WHERE IdCompte = UserIdCompte;
	END IF;
	
	end MAJDECOUVERTAUTORISE;
/

show err

create or replace procedure MAJMONTANTOPERATION(UserIdOperation int, valeur number)
is 
	IdCt int;
	MontOp NUMBER;
	SolCompte NUMBER;
	DecAut NUMBER;
	begin

	SELECT C.IdCompte, O.MontantOperation into IdCt, MontOp 
	FROM COMPTE C, OPERATION O 
	WHERE IdOperation = UserIdOperation 
	AND C.IdCompte = O.IdCompte;
	
	UPDATE Operation Set MontantOperation = valeur WHERE IdOperation = UserIdOperation;
	end MAJMONTANTOPERATION;
/

show err

create or replace procedure FAIRETRANSFERCOMPTE(UserCompteOrigine int,UserCompteDestinataire int, valeur number)
is 
begin
	AJOUTNOUVELOPERATION(UserCompteOrigine, -valeur);
	AJOUTNOUVELOPERATION(UserCompteDestinataire, valeur);
	end FAIRETRANSFERCOMPTE;
/

show err

create or replace function BANQUEOPERATION(UserIdOperation int) RETURN VARCHAR
is 
	LibBanque VARCHAR(100);
begin
	SELECT LibelleBanque into LibBanque FROM BANQUE B, OPERATION O, COMPTE C WHERE UserIdOperation = O.IdOperation
	AND O.IdCompte = C.IdCompte
	AND C.IdBanque = B.IdBanque;
	RETURN LibBanque;
	end BANQUEOPERATION;
/

show err

create or replace function SOLDECOMPTE(UserIdCompte int) RETURN number
is 
	Solde number(10,2);
begin
	SELECT SoldeCompte into Solde FROM Compte WHERE UserIdCompte = IdCompte;
	RETURN Solde;
	end SOLDECOMPTE;
/

show err