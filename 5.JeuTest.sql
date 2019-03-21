/* TEST OPERATION*/
SET ECHO ON;


/* On affiche l'etat du jeu d'essai avant manipulation*/


SELECT * FROM COMPTE;
SELECT * FROM OPERATION;
SELECT * FROM TYPECOMPTE;
SELECT * FROM AUDITDECOUVERT;
SELECT * FROM BANQUE;

/* On enleve 1500 au compte 3*/

EXEC AJOUTNOUVELOPERATION(3,-1500);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;

/* On ajoute 2300 au compte 4*/

EXEC AJOUTNOUVELOPERATION(4,2300);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;

/* On annule l'operation 5, l'inverse du montant de l'operation est applique au compte*/

EXEC ANNULEROPERATION(5);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;

/* On met le découvert autorise du compte 2 a -100*/

EXEC MAJDECOUVERTAUTORISE(2,-100);
SELECT * FROM COMPTE;


/* On met a jour le montant de l'operation 4, le solde du compte est egalement mis a jour*/

EXEC MAJMONTANTOPERATION(4,1245);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;


/* On transfert 450 du compte 3 au compte 4*/

EXEC FAIRETRANSFERCOMPTE(3,4, 450);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;


/* On affiche le libelle de la banque de l'operation 3, la 'Banque des riches'*/

SELECT BANQUEOPERATION(3) FROM DUAL;


/* On affiche le solde du compte 2, c'est a dire 0*/

SELECT SOLDECOMPTE(2) FROM DUAL;

/* TEST TRIGGER*/

/* On enleve 7000 au compte 4, qui est un compte d'epargne a 1000.
On plante le trigger et on annule l'operation*/

EXEC AJOUTNOUVELOPERATION(4,-7000);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;


/* On enleve 3000 au compte 2 qui est a 0 avec un decouvert autorise de -100
Une instance de ce compte est cree dans AUDITDECOUVERT*/

EXEC AJOUTNOUVELOPERATION(2,-3000);
SELECT * FROM AUDITDECOUVERT;


/* On enleve de nouveau 3000 au compte 2, son instance de AUDITDECOUVERT est mise à jour*/

EXEC AJOUTNOUVELOPERATION(2,-3000);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;
SELECT * FROM AUDITDECOUVERT;


/* On enleve 20000 au compte 3, qui a 10000 avec un decouvert de -2000
Une instance de ce compte est cree dans AUDITDECOUVERT*/

EXEC AJOUTNOUVELOPERATION(3,-20000);
SELECT * FROM AUDITDECOUVERT;


/* On annule l'operation precedente, le compte revient au dessus du découvert autorise.
Son instance dans AUDITDECOUVERT est supprimee*/

EXEC ANNULEROPERATION(13);
SELECT * FROM AUDITDECOUVERT;


/* On change le montant du decouvert du compte 3 à -40000*/

EXEC MAJDECOUVERTAUTORISE(3,-40000);


/* On annule l'operation precedente, c'est a dire la precedente annulation.
On applique donc -20000 au compte 3. Son decouvert ayant change, aucune instance
n'est creer dans AUDITDECOUVERT*/

EXEC ANNULEROPERATION(14);
SELECT * FROM AUDITDECOUVERT;


/* On modifie le montant de l'operation 11, les -3000 sur le compte 2.
Elle devient +10000, l'instance du compte est enlevee de AUDITDECOUVERT*/

EXEC MAJMONTANTOPERATION(11,10000);
SELECT * FROM COMPTE;
SELECT * FROM OPERATION;
SELECT * FROM AUDITDECOUVERT;


/* On transfert 20000 du compte 2 vers le compte 4, une nouvelle instance du compte2
2 est creer dans AUDITDECOUVERT*/

EXEC FAIRETRANSFERCOMPTE(2,4, 20000);
SELECT * FROM AUDITDECOUVERT;
SELECT * FROM COMPTE;


/* On veut transferer 40000 du compte 4 au compte 3, mais cela le mettrait a decouvert,
le trigger plante et annule l'operation*/

EXEC FAIRETRANSFERCOMPTE(4,3, 40000);

SET ECHO OFF;