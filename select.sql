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
-- 3.

-- 4.

-- 5.

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

-- 3.

-- 4.

-- 5.
        
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

-- Przykladowe wywolanie
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

-- Przykladowe wywolanie
SELECT validPesel(92121511352) FROM DUAL;

-- 3.

-- 4.

-- 5.

-- PROCEDURY
-- 1. Procedura aktualizujaca cene podanej ksiazki o podany procent
CREATE OR REPLACE PROCEDURE aktualizacja_ceny(id_prod IN number, procent IN number) IS
   
BEGIN
  UPDATE ksiazka SET CENA = CENA*procent/100 +CENA WHERE id = id_prod;    
END;

-- Przykladowe wywolanie
EXECUTE AKTUALIZACJA_CENY(1,50);

-- 2.

-- 3.

-- 4.

-- 5.

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

-- 2. Sprawdzenie czy data urodzenia nie jest data z przyszlosci
CREATE OR REPLACE TRIGGER checkBirthData BEFORE INSERT OR UPDATE ON daneOsobowe FOR EACH ROW
BEGIN
    IF :new.dataUr > sysdate THEN
      raise_application_error(-20326, 'Wrong - Date from the future');
    END IF;
END;

-- 3.

-- 4.

-- 5.

-- PAKIET
CREATE OR REPLACE PACKAGE pakiecik IS
  FUNCTION wiek(klient_id IN number) RETURN NUMBER;
  FUNCTION validPesel(pesel in NUMBER) RETURN NUMBER;
  PROCEDURE aktualizacja_ceny(id_prod IN number, procent IN number);
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

  PROCEDURE aktualizacja_ceny(id_prod IN number, procent IN number) IS 
  BEGIN
    UPDATE ksiazka SET CENA = CENA*procent/100 +CENA WHERE id = id_prod;    
  END;
END pakiecik;

-- Wywolanie
SELECT pakiecik.wiek(2) FROM DUAL;
SELECT pakiecik.validPesel(92121511355) FROM DUAL;
EXECUTE pakiecik.AKTUALIZACJA_CENY(1,50);