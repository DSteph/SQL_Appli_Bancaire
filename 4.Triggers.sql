CREATE OR REPLACE TRIGGER CALCULSOLDE
BEFORE INSERT or UPDATE or DELETE ON Operation
FOR EACH ROW
DECLARE
	LibCompte VARCHAR(20);
	LibTC VARCHAR(50);
	SolCompte NUMBER;
	DecCompte NUMBER;
	CountAudit NUMBER;
BEGIN
	
	SELECT C.LibelleCompte, C.SoldeCompte, C.DecouvertAutorise, TC.LibelleTypeCompte
	into LibCompte, SolCompte, DecCompte, LibTC
	FROM COMPTE C, TYPECOMPTE TC 
	WHERE C.IdCompte = :NEW.IdCompte 
	AND C.IdTypeCompte = TC.IdTypeCompte;
	
	SELECT COUNT(IdCompte) into CountAudit FROM AUDITDECOUVERT WHERE IdCompte = :New.IdCompte;
		
	IF (LibTC <> 'Compte Courant' AND (SolCompte + :NEW.MontantOperation) < 0)
		THEN
			RAISE_APPLICATION_ERROR(-20001,'Operation non autorisee, un compte epargne ne peut avoir de solde negatif');
		
	ELSIF (SolCompte + :NEW.MontantOperation > DecCompte)
		THEN
			DELETE FROM AUDITDECOUVERT WHERE IdCompte = :New.IdCompte;
			UPDATE Compte SET SoldeCompte = SoldeCompte + :NEW.MontantOperation WHERE IdCompte = :NEW.IdCompte;
		
	ELSIF (SolCompte + :NEW.MontantOperation < DecCompte AND CountAudit > 0)
		THEN
			UPDATE AUDITDECOUVERT SET SoldeCompte = SoldeCompte + :NEW.MontantOperation WHERE IdCompte = :NEW.IdCompte;
			UPDATE AUDITDECOUVERT SET Depassement = SoldeCompte - DecouvertAutorise;
			UPDATE AUDITDECOUVERT SET IdDerniereOperation = :NEW.IdOperation;
			UPDATE Compte SET SoldeCompte = SoldeCompte + :NEW.MontantOperation WHERE IdCompte = :NEW.IdCompte;
		
	ELSIF (SolCompte + :NEW.MontantOperation < DecCompte) 
		THEN 
			UPDATE Compte SET SoldeCompte = SoldeCompte + :NEW.MontantOperation WHERE IdCompte = :NEW.IdCompte;
			INSERT INTO AUDITDECOUVERT (IdAudit,IdCompte,LibelleCompte,SoldeCompte,DecouvertAutorise,Depassement,IdDerniereOperation)
			Values (CompteurAudit.NextVal, :NEW.IdCompte, LibCompte, SolCompte + :NEW.MontantOperation,DecCompte, 0, :NEW.IdOperation);
			UPDATE AUDITDECOUVERT SET Depassement = (SoldeCompte - DecouvertAutorise);
			
	ELSE
		UPDATE Compte SET SoldeCompte = SoldeCompte + :NEW.MontantOperation WHERE IdCompte = :NEW.IdCompte;
		
		
	END IF;
	
END;
/

show err

 