LOAD DATA
   INFILE 'Z:\BASE_DE_DONNEE\BD2\Seance5\DATA_CSV\CompteCC.csv'
   APPEND INTO TABLE CompteWork
   FIELDS TERMINATED BY ';'
   (LibelleCompteWork, DateOuvertureCompteWork,SoldeCompteWork)