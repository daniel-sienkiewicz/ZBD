-- Daniel Sienkiewicz
-- 206358

DROP TABLE "SYSTEM"."ADRES" cascade constraints PURGE;
DROP TABLE "SYSTEM"."AUTOR" cascade constraints PURGE;
DROP TABLE "SYSTEM"."DANEOSOBOWE" cascade constraints PURGE;
DROP TABLE "SYSTEM"."EGZEMPLARZ" cascade constraints PURGE;
DROP TABLE "SYSTEM"."GATUNEK" cascade constraints PURGE;
DROP TABLE "SYSTEM"."KLIENT" cascade constraints PURGE;
DROP TABLE "SYSTEM"."KSIAZKA" cascade constraints PURGE;
DROP TABLE "SYSTEM"."ODDZIAL" cascade constraints PURGE;
DROP TABLE "SYSTEM"."REZERWACJA" cascade constraints PURGE;
DROP TABLE "SYSTEM"."SPRZEDAZ" cascade constraints PURGE;
DROP TABLE "SYSTEM"."STAN" cascade constraints PURGE;
DROP TABLE "SYSTEM"."STANOWISKO" cascade constraints PURGE;
DROP TABLE "SYSTEM"."TYP" cascade constraints PURGE;
DROP TABLE "SYSTEM"."WYDAWNICTWO" cascade constraints PURGE;
DROP TABLE "SYSTEM"."WYPLATA" cascade constraints PURGE;
DROP TABLE "SYSTEM"."PRACOWNIK" cascade constraints PURGE;
DROP TABLE "SYSTEM"."PREMIA" cascade constraints PURGE;
DROP TABLE "SYSTEM"."RABAT" cascade constraints PURGE;
DROP TABLE "SYSTEM"."RELATION_12" cascade constraints PURGE;
DROP TABLE "SYSTEM"."RELATION_25" cascade constraints PURGE;
DROP TABLE "SYSTEM"."RELATION_37" cascade constraints PURGE;
DROP TABLE "SYSTEM"."RELATION_38" cascade constraints PURGE;
DROP TABLE "SYSTEM"."RELATION_39" cascade constraints PURGE;

DROP SEQUENCE autor_id_SEQ;
DROP SEQUENCE daneOsobowe_id_SEQ;
DROP SEQUENCE egzemplarz_id_SEQ;
DROP SEQUENCE gatunek_id_SEQ;
DROP SEQUENCE klient_id_SEQ; 
DROP SEQUENCE ksiazka_id_SEQ;
DROP SEQUENCE oddzial_id_SEQ;
DROP SEQUENCE pracownik_id_SEQ;
DROP SEQUENCE premia_id_SEQ;
DROP SEQUENCE rabat_id_SEQ;
DROP SEQUENCE rezerwacja_id_SEQ;
DROP SEQUENCE sprzedaz_id_SEQ;
DROP SEQUENCE stan_id_SEQ; 
DROP SEQUENCE stanowisko_id_SEQ; 
DROP SEQUENCE typ_id_SEQ;
DROP SEQUENCE wydawnictwo_id_SEQ;
DROP SEQUENCE wyplata_id_SEQ;
DROP SEQUENCE adres_id_SEQ;