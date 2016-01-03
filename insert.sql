-- Daniel Sienkiewicz
-- 206358

--- Stan --
INSERT INTO stan (nazwa) VALUES ('Nowy');
INSERT INTO stan (nazwa) VALUES ('Uzywany');

-- Typ --
INSERT INTO typ (nazwa) VALUES ('e-book');
INSERT INTO typ (nazwa) VALUES ('audio-book');
INSERT INTO typ (nazwa) VALUES ('ksiazka');

-- Wydawnictwo --
INSERT INTO wydawnictwo (nazwa) VALUES ('AAA');
INSERT INTO wydawnictwo (nazwa) VALUES ('BBB');
INSERT INTO wydawnictwo (nazwa) VALUES ('CCC');

-- Gatunek --
INSERT INTO gatunek (nazwa) VALUES ('Horror');
INSERT INTO gatunek (nazwa) VALUES ('Komiks');
INSERT INTO gatunek (nazwa) VALUES ('Literatura faktu');

-- Premia --
INSERT INTO premia (wielkosc, okazja) VALUES (12, 'Jubileusz 25');
INSERT INTO premia (wielkosc, okazja) VALUES (20, 'Jubileusz 30');
INSERT INTO premia (wielkosc, okazja) VALUES (50, 'Super pracownik');

-- Wyplata --
INSERT INTO wyplata (brutto, netto) VALUES (1800, 1300);
INSERT INTO wyplata (brutto, netto) VALUES (2000, 1800);
INSERT INTO wyplata (brutto, netto) VALUES (1500, 1000);

-- Stanowisko --
INSERT INTO stanowisko (nazwa, wyplata_id) VALUES ('Kierownik', 2);
INSERT INTO stanowisko (nazwa, wyplata_id) VALUES ('Sprzedawca', 1);
INSERT INTO stanowisko (nazwa, wyplata_id) VALUES ('Mlodszy sprzedawca', 1);
INSERT INTO stanowisko (nazwa, wyplata_id) VALUES ('Sprzataczka', 3);
INSERT INTO stanowisko (nazwa, wyplata_id) VALUES ('Ochroniarz', 3);
INSERT INTO stanowisko (nazwa, wyplata_id) VALUES ('Prezes', 2);

-- Adres --
INSERT into adres (ulica, nrDomu, nrMieszkania, miasto, kodPocztowy) VALUES ('Ratownikow', '7', 13, 'Polkowice', '59-100');
INSERT into adres (ulica, nrDomu, nrMieszkania, miasto, kodPocztowy) VALUES ('Piastowska', '159a' , 3, 'Gdansk', '80-358');
INSERT into adres (ulica, nrDomu, nrMieszkania, miasto, kodPocztowy) VALUES ('Kartuska', '39', 4, 'Gdansk', '80-358');
INSERT into adres (ulica, nrDomu, nrMieszkania, miasto, kodPocztowy) VALUES ('Chlopska', '15', 4, 'Gdansk', '80-358');
INSERT into adres (ulica, nrDomu, nrMieszkania, miasto, kodPocztowy) VALUES ('Morska', '4', 6, 'Gdynia', '58-485');
INSERT into adres (ulica, nrDomu, nrMieszkania, miasto, kodPocztowy) VALUES ('Rybolowcow', '13', 4, 'Gdansk', '80-543');

-- Dane Osobowe --
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Konio', 'Kon', TO_DATE('2003/05/03', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Ktos', 'Taki', TO_DATE('1992/02/01', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Maly', 'Duzy', TO_DATE('1993/12/06', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Ala', 'Kot', TO_DATE('1989/10/02', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Pawel', 'Wityk', TO_DATE('1999/03/03', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Magik', 'Zygar', TO_DATE('2001/05/03', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Kasia', 'Zygar', TO_DATE('2002/01/01', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Ada', 'Mis', TO_DATE('1995/04/15', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Maciek', 'Maciejewski', TO_DATE('1978/03/13', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Daniel', 'Dan', TO_DATE('2008/06/08', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Paulina', 'Pina', TO_DATE('1965/04/12', 'yyyy/mm/dd'), '92121511350', '5261455');
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Kuba', 'Skarzynski', TO_DATE('1986/12/30', 'yyyy/mm/dd'), '92121511350', '5261455');

-- Klient --
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(11, 1, 1);
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(12, 2, 2);
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(13, 3, 3);
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(14, 4, 4);
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(15, 5, 5);
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(16, 6, 6);
INSERT INTO klient (nrKlienta, daneOsobowe_id, adres_id) VALUES(17, 7, 6);

-- Oddzial --
INSERT INTO oddzial (nazwa, adres_id) VALUES ('Pierwsza', 1);
INSERT INTO oddzial (nazwa, adres_id) VALUES ('Druga', 2);
INSERT INTO oddzial (nazwa, adres_id) VALUES ('Trzecia', 3);

-- Ksiazka --
INSERT INTO ksiazka (tytul, rokWydania, liczbaStron, cena, gatunek_id) VALUES ('Java', 1986, 234, 25, 1);
INSERT INTO ksiazka (tytul, rokWydania, liczbaStron, cena, gatunek_id) VALUES ('Matematyka', 1963, 32, 36, 2);
INSERT INTO ksiazka (tytul, rokWydania, liczbaStron, cena, gatunek_id) VALUES ('Jadro Ciemnosci', 2001, 322, 36, 2);
INSERT INTO ksiazka (tytul, rokWydania, liczbaStron, cena, gatunek_id) VALUES ('Maly ksiaze', 1999, 23, 52, 1);
INSERT INTO ksiazka (tytul, rokWydania, liczbaStron, cena, gatunek_id) VALUES ('Pan tadeusz', 1965, 23, 69, 2);
INSERT INTO ksiazka (tytul, rokWydania, liczbaStron, cena, gatunek_id) VALUES ('Potop', 2015, 2333, 17, 2);

-- Pracownik --
INSERT INTO pracownik (nrSluzbowy, daneOsobowe_id, stanowisko_id, oddzial_id, adres_id) VALUES (2, 5, 1, 1, 1);
INSERT INTO pracownik (nrSluzbowy, daneOsobowe_id, stanowisko_id, oddzial_id, adres_id) VALUES (3, 6, 2, 2, 2);
INSERT INTO pracownik (nrSluzbowy, daneOsobowe_id, stanowisko_id, oddzial_id, adres_id) VALUES (4, 7, 3, 2, 3);
INSERT INTO pracownik (nrSluzbowy, daneOsobowe_id, stanowisko_id, oddzial_id, adres_id) VALUES (5, 8, 4, 3, 4);
INSERT INTO pracownik (nrSluzbowy, daneOsobowe_id, stanowisko_id, oddzial_id, adres_id) VALUES (6, 9, 5, 1, 5);

-- Sprzedaz --
INSERT INTO sprzedaz (dataSprzedazy, klient_id, oddzial_id) VALUES (TO_DATE('2008/06/08', 'yyyy/mm/dd'), 1, 1);
INSERT INTO sprzedaz (dataSprzedazy, klient_id, oddzial_id) VALUES (TO_DATE('2012/08/08', 'yyyy/mm/dd'), 1, 2);
INSERT INTO sprzedaz (dataSprzedazy, klient_id, oddzial_id) VALUES (TO_DATE('2015/03/08', 'yyyy/mm/dd'), 2, 2);
INSERT INTO sprzedaz (dataSprzedazy, klient_id, oddzial_id) VALUES (TO_DATE('1992/01/08', 'yyyy/mm/dd'), 4, 1);

-- Autor --
INSERT INTO autor (daneOsobowe_id) VALUES (7);
INSERT INTO autor (daneOsobowe_id) VALUES (8);
INSERT INTO autor (daneOsobowe_id) VALUES (9);
INSERT INTO autor (daneOsobowe_id) VALUES (10);

-- Rabat --
INSERT INTO rabat (wielkosc, aktywny, waznyDo, klient_id) VALUES (10, 'T', TO_DATE('1992/01/08', 'yyyy/mm/dd'), 1);
INSERT INTO rabat (wielkosc, aktywny, waznyDo, klient_id) VALUES (20, 'T', TO_DATE('2015/01/08', 'yyyy/mm/dd'), 2);
INSERT INTO rabat (wielkosc, aktywny, waznyDo, klient_id) VALUES (1, 'N', TO_DATE('2015/10/08', 'yyyy/mm/dd'), 3);
INSERT INTO rabat (wielkosc, aktywny, waznyDo, klient_id) VALUES (50, 'T', TO_DATE('2010/11/08', 'yyyy/mm/dd'), 4);

-- Rezerwacja --
INSERT INTO rezerwacja (naKiedy, klient_id) VALUES (TO_DATE('2015/11/08', 'yyyy/mm/dd'), 3);
INSERT INTO rezerwacja (naKiedy, klient_id) VALUES (TO_DATE('2010/11/08', 'yyyy/mm/dd'), 2);
INSERT INTO rezerwacja (naKiedy, klient_id) VALUES (TO_DATE('2016/12/08', 'yyyy/mm/dd'), 1);

-- Egzemplarz --
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('T', 1, 1, 1, 1);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('N', 2, 2, 2, 2);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('T', 3, 2, 1, 2);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('T', 1, 1, 2, 3);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('T', 1, 1, 1, 1);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('N', 2, 2, 2, 2);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('T', 3, 2, 1, 2);
INSERT INTO egzemplarz (dostepny, ksiazka_id, typ_id, stan_id, oddzial_id) VALUES ('T', 1, 1, 2, 3);

-- Relation 25 --
INSERT INTO relation_25 (wydawnictwo_id, ksiazka_id) VALUES (1, 1);
INSERT INTO relation_25 (wydawnictwo_id, ksiazka_id) VALUES (2, 2);
INSERT INTO relation_25 (wydawnictwo_id, ksiazka_id) VALUES (3, 3);
INSERT INTO relation_25 (wydawnictwo_id, ksiazka_id) VALUES (1, 3);
INSERT INTO relation_25 (wydawnictwo_id, ksiazka_id) VALUES (3, 4);
INSERT INTO relation_25 (wydawnictwo_id, ksiazka_id) VALUES (1, 4);

-- Relation 12 --
INSERT INTO relation_12 (autor_id, ksiazka_id) VALUES (1, 1);
INSERT INTO relation_12 (autor_id, ksiazka_id) VALUES (2, 2);
INSERT INTO relation_12 (autor_id, ksiazka_id) VALUES (3, 3);
INSERT INTO relation_12 (autor_id, ksiazka_id) VALUES (4, 4);
INSERT INTO relation_12 (autor_id, ksiazka_id) VALUES (1, 5);
INSERT INTO relation_12 (autor_id, ksiazka_id) VALUES (2, 6);

-- Relation 37 --
INSERT INTO relation_37 (pracownik_id, premia_id) VALUES (1, 1);
INSERT INTO relation_37 (pracownik_id, premia_id) VALUES (2, 2);
INSERT INTO relation_37 (pracownik_id, premia_id) VALUES (3, 3);
INSERT INTO relation_37 (pracownik_id, premia_id) VALUES (4, 1);
INSERT INTO relation_37 (pracownik_id, premia_id) VALUES (5, 2);
INSERT INTO relation_37 (pracownik_id, premia_id) VALUES (1, 3);

-- Relation 38 --
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (1, 1);
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (2, 2);
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (3, 3);
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (4, 4);
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (1, 5);
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (2, 6);
INSERT INTO relation_38 (sprzedaz_id, egzemplarz_id) VALUES (3, 7);

-- Relation 39 --
INSERT INTO relation_39 (rezerwacja_id, egzemplarz_id) VALUES (1, 1);
INSERT INTO relation_39 (rezerwacja_id, egzemplarz_id) VALUES (2, 2);
INSERT INTO relation_39 (rezerwacja_id, egzemplarz_id) VALUES (3, 3);
INSERT INTO relation_39 (rezerwacja_id, egzemplarz_id) VALUES (1, 4);
INSERT INTO relation_39 (rezerwacja_id, egzemplarz_id) VALUES (3, 5);
INSERT INTO relation_39 (rezerwacja_id, egzemplarz_id) VALUES (1, 6);