drop table Banque cascade constraint purge;
drop table Operation cascade constraint purge;
drop table Compte cascade constraint purge;
drop table TypeCompte cascade constraint purge;
drop table AuditDecouvert cascade constraint purge;
drop table CompteWork cascade constraint purge;
drop table OperationWork cascade constraint purge;

drop SEQUENCE CompteurBanque;
drop SEQUENCE CompteurTypeCompte;
drop SEQUENCE CompteurCompte;
drop SEQUENCE CompteurOperation;
drop SEQUENCE CompteurAudit;

CLEAR SCREEN;