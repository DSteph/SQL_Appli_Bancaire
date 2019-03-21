INSERT INTO Compte (IdCompte, LibelleCompte,SoldeCompte,DecouvertAutorise,DateOuvertureCompte,IdBanque,IdTypeCompte)
SELECT CompteurCompte.NextVal, LibelleCompteWork, SoldeCompteWork, DecouvertAutoriseCompteWork, DateOuvertureCompteWork, 2,'Compte Courant'
FROM CompteWork;
