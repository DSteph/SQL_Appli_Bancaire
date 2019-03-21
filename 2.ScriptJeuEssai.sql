CREATE SEQUENCE CompteurBanque;
CREATE SEQUENCE CompteurTypeCompte;
CREATE SEQUENCE CompteurCompte;
CREATE SEQUENCE CompteurOperation;
CREATE SEQUENCE CompteurAudit;

INSERT INTO Banque (IdBanque, LibelleBanque, CPBanque, AdresseBanque, VilleBanque) Values (CompteurBanque.NextVal, 'Banque des pauvres','95666', '999 Rue du manchon', 'GregorVille');
INSERT INTO TypeCompte (IdTypeCompte, LibelleTypeCompte) Values (CompteurTypeCompte.NextVal, 'Compte Courant');
INSERT INTO Compte (IdCompte, LibelleCompte, SoldeCompte, DecouvertAutorise,DateOuvertureCompte,IdBanque,IdTypeCompte) Values (CompteurCompte.NextVal, '2','0','-500', '12/12/2012',CompteurBanque.CurrVal,CompteurTypeCompte.Currval);
INSERT INTO Operation (IdOperation,DateOperation,MontantOperation,IdCompte) Values (CompteurOperation.NextVal, SYSDATE, +200, CompteurCompte.Currval);

INSERT INTO Banque (IdBanque, LibelleBanque, CPBanque, AdresseBanque, VilleBanque) Values (CompteurBanque.NextVal, 'Banque des riches','10120', '22 Avenue Machin', 'SinCity');
INSERT INTO TypeCompte (IdTypeCompte, LibelleTypeCompte) Values (CompteurTypeCompte.NextVal, 'Compte Courant');
INSERT INTO Compte (IdCompte, LibelleCompte, SoldeCompte, DecouvertAutorise,DateOuvertureCompte,IdBanque,IdTypeCompte) Values (CompteurCompte.NextVal, '4','10000','-2000', '22/06/1998',CompteurBanque.CurrVal,CompteurTypeCompte.Currval);
INSERT INTO Operation (IdOperation,DateOperation,MontantOperation,IdCompte) Values (CompteurOperation.NextVal, SYSDATE, -7500, CompteurCompte.Currval);

INSERT INTO Banque (IdBanque, LibelleBanque, CPBanque, AdresseBanque, VilleBanque) Values (CompteurBanque.NextVal, 'Banque normale','10120', '65 Avenue Truc', 'SinCity');
INSERT INTO TypeCompte (IdTypeCompte, LibelleTypeCompte) Values (CompteurTypeCompte.NextVal, 'Livret A');
INSERT INTO Compte (IdCompte, LibelleCompte, SoldeCompte, DecouvertAutorise,DateOuvertureCompte,IdBanque,IdTypeCompte) Values (CompteurCompte.NextVal, '6','1000','0', '08/02/2002',CompteurBanque.CurrVal,CompteurTypeCompte.Currval);
INSERT INTO Operation (IdOperation,DateOperation,MontantOperation,IdCompte) Values (CompteurOperation.NextVal, SYSDATE, +4500, CompteurCompte.Currval);
