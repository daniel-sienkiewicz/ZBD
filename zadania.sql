-- Daniel Sienkiewicz
-- 206358

SET SERVEROUTPUT ON

-- SELECT
-- 1. Ile ksiazek z danego gatunku zakupil klient
SELECT DISTINCT g.nazwa, count(*) AS liczba FROM ksiazka k 
  JOIN egzemplarz e ON k.id = e.ksiazka_id JOIN Relation_38 r38 ON e.id = r38.EGZEMPLARZ_ID 
    JOIN sprzedaz s ON r38.sprzedaz_id = s.id JOIN klient kl ON s.klient_id = kl.id 
      JOIN gatunek g ON k.GATUNEK_ID = g.id 
        WHERE kl.id = 4 group by g.nazwa;

-- 2. Wypisanie top klientow
SELECT DISTINCT do.nazwisko, count(*) AS liczba FROM sprzedaz s 
  JOIN klient k ON k.id  = s.klient_id 
    JOIN daneOsobowe do ON k.DANEOSOBOWE_ID = do.id 
      group by do.nazwisko 
        ORDER BY liczba DESC;
		
-- 3. Wyszukanie kllientow ktorzy nie podali nr telefonu
SELECT k.nrKlienta, do.imie FROM klient k 
	JOIN daneOsobowe do ON k.DANEOSOBOWE_ID = do.id 
		WHERE do.nrTelefonu IS NULL;
		
-- 4. Wypisanie klientow bez rabatu
SELECT k.nrKlienta, do.imie FROM klient k
	JOIN daneosobowe do ON k.daneosobowe_id = do.id
		WHERE k.id NOT IN (SELECT klient_id FROM rabat); 

-- 5. Wypisanie ile ksiazek napisal dany autor
SELECT a.id, count (*) AS liczba FROM ksiazka k 
	JOIN Relation_12 r12 ON k.id = r12.ksiazka_id
		JOIN autor a ON a.id = r12.autor_id
			JOIN daneOsobowe do ON do.id = a.daneOsobowe_id 
				WHERE a.id = 1 group by a.id;

-- WIDOKI
-- 1. Zliczenie kupionych ksiazek w kategoriach
CREATE OR REPLACE VIEW countBoughtBook AS
  SELECT DISTINCT g.nazwa, count(*) AS liczba FROM ksiazka k 
    JOIN egzemplarz e ON k.id = e.ksiazka_id JOIN Relation_38 r38 ON e.id = r38.EGZEMPLARZ_ID 
      JOIN sprzedaz s ON r38.sprzedaz_id = s.id JOIN klient kl ON s.klient_id = kl.id 
        JOIN gatunek g ON k.GATUNEK_ID = g.id 
           group by g.nazwa;

-- Wywolanie     
SELECT * FROM countBoughtBook;

-- 2. Wypisanie top klientow
CREATE OR REPLACE VIEW topKlients AS
  SELECT DISTINCT do.nazwisko, count(*) AS liczba FROM sprzedaz s 
    JOIN klient k ON k.id  = s.klient_id 
      JOIN daneOsobowe do ON k.DANEOSOBOWE_ID = do.id 
        group by do.nazwisko 
          ORDER BY liczba DESC;
          
-- Wywolanie     
SELECT * FROM topKlients;  

-- 3. Wyszukanie kllientow ktorzy nie podali nr telefonu
CREATE OR REPLACE VIEW notTel AS
	SELECT k.nrKlienta, do.imie from klient k 
		JOIN daneOsobowe do ON k.DANEOSOBOWE_ID = do.id 
			WHERE do.nrTelefonu IS NULL;

-- Wywolanie     
SELECT * FROM notTel;  
			
-- 4. Wypisanie klientow bez rabatu
CREATE OR REPLACE VIEW notRabat AS
	SELECT k.nrKlienta, do.imie FROM klient k
		JOIN daneosobowe do ON k.daneosobowe_id = do.id
			WHERE k.id NOT IN (SELECT klient_id FROM rabat); 

-- Wywolanie     
SELECT * FROM notRabat;  
			
-- 5. Wypisanie ile ksiazek napisal dany autor
CREATE OR REPLACE VIEW countBooks AS
	SELECT a.id, count (*) AS liczba FROM ksiazka k 
		JOIN Relation_12 r12 ON k.id = r12.ksiazka_id
			JOIN autor a ON a.id = r12.autor_id
				JOIN daneOsobowe do ON do.id = a.daneOsobowe_id group by a.id;
				
-- Wywolanie     
SELECT * FROM countBooks where id = 1;

-- FUNKCJE
-- 1. Funkcja obliczajaca wiek podanego klienta
CREATE OR REPLACE FUNCTION wiek(klient_id IN number) 
  RETURN number IS
  wiek number := 0;
  dzis number := 0;
  rok number := 0;
BEGIN
  SELECT to_char(DataUr,'YYYY') INTO rok FROM daneOsobowe do JOIN klient k ON do.id = k.DANEOSOBOWE_ID WHERE k.id = klient_id;
  SELECT to_char(sysdate,'YYYY') INTO dzis FROM DUAL;
 
  RETURN (dzis-rok);
END;

-- Wywolanie
SELECT wiek(1) FROM DUAL;

-- 2. Funkcja sprawdzajaca poprawnosc PESEL
CREATE OR REPLACE FUNCTION validPesel(pesel in NUMBER)
  RETURN NUMBER IS
  BEGIN
  IF (mod(10 - substr((substr(TO_CHAR(pesel),1,1)*1)
        +(substr(TO_CHAR(pesel),2,1)*3)
        +(substr(TO_CHAR(pesel),3,1)*7)
        +(substr(TO_CHAR(pesel),4,1)*9)
        +(substr(TO_CHAR(pesel),5,1)*1)
        +(substr(TO_CHAR(pesel),6,1)*3)
        +(substr(TO_CHAR(pesel),7,1)*7)
        +(substr(TO_CHAR(pesel),8,1)*9)
        +(substr(TO_CHAR(pesel),9,1)*1)
        +(substr(TO_CHAR(pesel),10,1)*3),2), 10) = substr(TO_CHAR(pesel),11)) THEN
      RETURN 1;
  END IF;
  RETURN 0;
END;

-- Wywolanie
SELECT validPesel(92121511352) FROM DUAL;
SELECT validPesel(92121511350) FROM DUAL;

-- 3. Funkcja sprawdzajaca czy dany egzemplarz jest dostepny
CREATE OR REPLACE FUNCTION isFree(id_egz in NUMBER)
  RETURN NUMBER IS
  wynik NUMBER := 0;
  BEGIN
    SELECT id_egz INTO wynik FROM DUAL WHERE id_egz IN (SELECT id from egzemplarz where id NOT IN 
      (SELECT e.id FROM egzemplarz e 
        JOIN Relation_39 r39 ON e.id = r39.EGZEMPLARZ_ID
          JOIN rezerwacja r ON r.id = r39.rezerwacja_id));
  if(wynik = null) THEN
    RETURN 0;
  END IF;
  
  RETURN 1;
END;

-- Wywolanie
SELECT isFree(7) FROM DUAL;
SELECT isFree(1) FROM DUAL;

-- 4. Ile ksiazek ma dane wydawnictwo
CREATE OR REPLACE FUNCTION ileWydawnictwo(id_wyd in NUMBER)
  RETURN NUMBER IS
  wynik NUMBER := 0;
  BEGIN
    SELECT count(*) INTO wynik FROM wydawnictwo w 
      JOIN Relation_25 r25 ON w.id = r25.wydawnictwo_id
        JOIN ksiazka k ON k.id = r25.ksiazka_id
          WHERE w.id = id_wyd;
  RETURN wynik;
END;

-- Wywolanie
SELECT  ileWydawnictwo(1) FROM dual;

-- 5. Wypisanie ID ksiazki ktorj jest najmniej
CREATE OR REPLACE FUNCTION minBook
  RETURN NUMBER IS
  wynik number := 0;
  BEGIN
    SELECT id INTO wynik FROM (SELECT k.id, count(*) AS ilosc FROM ksiazka k 
      JOIN egzemplarz e ON e.ksiazka_id = k.id 
        group by k.id order by ilosc ASC) WHERE ROWNUM = 1;
        
    RETURN wynik;
  END;
  
-- Wywolanie
  SELECT minBook FROM dual;

-- PROCEDURY
-- 1. Procedura aktualizujaca cene podanej ksiazki o podany procent
CREATE OR REPLACE PROCEDURE aktualizacja_ceny(id_prod IN number, procent IN number) IS
   
BEGIN
  UPDATE ksiazka SET CENA = CENA*procent/100 +CENA WHERE id = id_prod;    
END;

-- Wywolanie
EXECUTE AKTUALIZACJA_CENY(1,50);

-- 2. Dodaj rabat dla czyteolnika
CREATE OR REPLACE PROCEDURE dodaj_rabat(id_rabat IN number, id_klient IN number) IS
   
BEGIN
  UPDATE rabat SET klient_id = id_klient WHERE id = id_rabat;    
END;

-- Wywolanie
EXECUTE dodaj_rabat(1,6);

-- 3. Oznaczanie rabatu jako niekatywny
CREATE OR REPLACE PROCEDURE deRabat(id_rabat IN number) IS
   
BEGIN
  UPDATE rabat SET aktywny = 'N' WHERE id = id_rabat;    
END;

-- Wywolanie
EXECUTE deRabat(3);

-- 4.Procedura usuwaj¹ca autora
CREATE OR REPLACE PROCEDURE delAutor(id_autor IN number) IS
   
BEGIN
  DELETE FROM Relation_12 where autor_id = id_autor;
  DELETE FROM autor where id = id_autor;    
END;

-- Wywolanie
EXECUTE delAutor(2);

-- 5. Procedura zwi¹kszaj¹ca premie o podany procent
CREATE OR REPLACE PROCEDURE aktualizacja_premii(id_premia IN number, procent IN number) IS
BEGIN
  UPDATE premia SET wielkosc = wielkosc*procent/100 +wielkosc WHERE id = id_premia;    
END;

-- Wywolanie
EXECUTE aktualizacja_premii(1,50);

-- Przeciazenie
CREATE OR REPLACE PROCEDURE aktualizacja_ceny(procent IN number) IS
   
BEGIN
  UPDATE ksiazka SET CENA = CENA*procent/100 +CENA;    
END;

-- Wywolanie
EXECUTE Aktualizacja_ceny(2);

-- WYZWALACZE
-- 1. Sprawdzanie poprawnosci PESEL
CREATE OR REPLACE TRIGGER checkPesel BEFORE INSERT OR UPDATE ON daneOsobowe FOR EACH ROW
DECLARE
  tmp NUMBER := 0;
BEGIN
    SELECT validPesel(:new.pesel) INTO tmp FROM DUAL;
    IF (LENGTH(:new.pesel) != 11) OR tmp = 0 THEN
      raise_application_error(-20326, 'Wrong - PESEL');
    END IF;
END;

-- Wywolanie
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu, plec) VALUES ('Konio', 'Kon', TO_DATE('2003/05/03', 'yyyy/mm/dd'), '92121511358', '5261455', 'M');

-- 2. Sprawdzenie czy data urodzenia nie jest data z przyszlosci
CREATE OR REPLACE TRIGGER checkBirthData BEFORE INSERT OR UPDATE ON daneOsobowe FOR EACH ROW
BEGIN
    IF :new.dataUr > sysdate THEN
      raise_application_error(-20326, 'Wrong - Date from the future');
    END IF;
END;

-- Wywolanie
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu, plec) VALUES ('Konio', 'Kon', TO_DATE('2018/05/03', 'yyyy/mm/dd'), '92121511350', '5261455', 'M');

-- 3. Automatycznie ustawianie plci klienta poprze PESEL
CREATE OR REPLACE TRIGGER check_sex AFTER INSERT ON daneOsobowe
DECLARE
idk number := 0;
pesel_new number := 0;
  BEGIN
    SELECT id, pesel INTO idk, pesel_new FROM daneOsobowe WHERE id = (SELECT max(id) FROM daneOsobowe);
    
    IF (mod(substr(TO_CHAR(pesel_new),11,1), 2) = 0) THEN
      UPDATE daneOsobowe SET plec = 'M' WHERE id = idk;
    ELSE
      UPDATE daneOsobowe SET plec = 'K' WHERE id = idk;
    END IF;
  END;

-- Wywolanie
INSERT INTO daneOsobowe (imie, nazwisko, dataUr, pesel, nrTelefonu) VALUES ('Konio', 'Kon', TO_DATE('2012/05/03', 'yyyy/mm/dd'), '92121511350', '5261455');

-- PAKIET
CREATE OR REPLACE PACKAGE pakiecik IS
  FUNCTION wiek(klient_id IN number) RETURN NUMBER;
  FUNCTION validPesel(pesel in NUMBER) RETURN NUMBER;
  FUNCTION isFree(id_egz in NUMBER)	RETURN NUMBER;
  FUNCTION ileWydawnictwo(id_wyd in NUMBER) RETURN NUMBER;
  FUNCTION minBook RETURN NUMBER;
  PROCEDURE dodaj_rabat(id_rabat IN number, id_klient IN number);
  PROCEDURE aktualizacja_ceny(id_prod IN number, procent IN number);
  PROCEDURE deRabat(id_rabat IN number);
  PROCEDURE delAutor(id_autor IN number);
  PROCEDURE aktualizacja_premii(id_premia IN number, procent IN number);
  PROCEDURE aktualizacja_ceny(procent IN number);
END pakiecik;

CREATE OR REPLACE PACKAGE BODY pakiecik IS
  FUNCTION wiek(klient_id IN number) 
    RETURN number IS
    wiek number := 0;
    dzis number := 0;
    rok number := 0;
  BEGIN
    SELECT to_char(DataUr,'YYYY') INTO rok FROM daneOsobowe do JOIN klient k ON do.id = k.DANEOSOBOWE_ID WHERE k.id = klient_id;
    SELECT to_char(sysdate,'YYYY') INTO dzis FROM DUAL;
    RETURN (dzis-rok);
  END;

  FUNCTION validPesel(pesel in NUMBER)
    RETURN NUMBER IS
    BEGIN
      IF (mod(10 - substr((substr(TO_CHAR(pesel),1,1)*1)
        +(substr(TO_CHAR(pesel),2,1)*3)
        +(substr(TO_CHAR(pesel),3,1)*7)
        +(substr(TO_CHAR(pesel),4,1)*9)
        +(substr(TO_CHAR(pesel),5,1)*1)
        +(substr(TO_CHAR(pesel),6,1)*3)
        +(substr(TO_CHAR(pesel),7,1)*7)
        +(substr(TO_CHAR(pesel),8,1)*9)
        +(substr(TO_CHAR(pesel),9,1)*1)
        +(substr(TO_CHAR(pesel),10,1)*3),2), 10) = substr(TO_CHAR(pesel),11)) THEN
        RETURN 1;
      END IF;
    RETURN 0;
  END;
  
  FUNCTION isFree(id_egz in NUMBER)
	RETURN NUMBER IS
	wynik NUMBER := 0;
	BEGIN
		SELECT id_egz INTO wynik FROM DUAL WHERE id_egz IN (SELECT id from egzemplarz where id NOT IN 
			(SELECT e.id FROM egzemplarz e 
				JOIN Relation_39 r39 ON e.id = r39.EGZEMPLARZ_ID
					JOIN rezerwacja r ON r.id = r39.rezerwacja_id));
		if(wynik = null) THEN
			RETURN 0;
		END IF;
	RETURN 1;
  END;
  
  FUNCTION ileWydawnictwo(id_wyd in NUMBER)
  RETURN NUMBER IS
  wynik NUMBER := 0;
  BEGIN
    SELECT count(*) INTO wynik FROM wydawnictwo w 
      JOIN Relation_25 r25 ON w.id = r25.wydawnictwo_id
        JOIN ksiazka k ON k.id = r25.ksiazka_id
          WHERE w.id = id_wyd;
  RETURN wynik;
  END;
  
  FUNCTION minBook
  RETURN NUMBER IS
  wynik number := 0;
  BEGIN
    SELECT id INTO wynik FROM (SELECT k.id, count(*) AS ilosc FROM ksiazka k 
      JOIN egzemplarz e ON e.ksiazka_id = k.id 
        group by k.id order by ilosc ASC) WHERE ROWNUM = 1;
        
    RETURN wynik;
  END;

  PROCEDURE aktualizacja_ceny(id_prod IN number, procent IN number) IS 
  BEGIN
    UPDATE ksiazka SET CENA = CENA*procent/100 +CENA WHERE id = id_prod;    
  END;
  
  PROCEDURE dodaj_rabat(id_rabat IN number, id_klient IN number) IS
  BEGIN
	UPDATE rabat SET klient_id = id_klient WHERE id = id_rabat;    
  END;
  
  PROCEDURE deRabat(id_rabat IN number) IS
  BEGIN
	UPDATE rabat SET aktywny = 'N' WHERE id = id_rabat;    
  END;
  
  PROCEDURE delAutor(id_autor IN number) IS
  BEGIN
	DELETE FROM Relation_12 where autor_id = id_autor;
	DELETE FROM autor where id = id_autor;    
  END;
  
  PROCEDURE aktualizacja_premii(id_premia IN number, procent IN number) IS
  BEGIN
	UPDATE premia SET wielkosc = wielkosc*procent/100 +wielkosc WHERE id = id_premia;    
  END;
  
  PROCEDURE aktualizacja_ceny(procent IN number) IS
  BEGIN
	UPDATE ksiazka SET CENA = CENA*procent/100 +CENA;    
  END;
END pakiecik;

-- Wywolanie
SELECT pakiecik.wiek(2) FROM DUAL;
SELECT pakiecik.validPesel(92121511355) FROM DUAL;
SELECT pakiecik.isFree(7) FROM DUAL;
SELECT pakiecik.ileWydawnictwo(1) FROM dual;
SELECT pakiecik.minBook FROM dual;
EXECUTE pakiecik.dodaj_rabat(1,6);
EXECUTE pakiecik.AKTUALIZACJA_CENY(1,50);
EXECUTE pakiecik.deRabat(3);
EXECUTE pakiecik.delAutor(2);
EXECUTE pakiecik.aktualizacja_premii(1,50);