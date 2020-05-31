use [Kemping]
GO

--1
DROP VIEW IF EXISTS Client_Reserwacja 
GO

CREATE VIEW Client_Reserwacja AS
Select r.idRezerwacji,r.DataRezerwacji,r.DataZwolnienia,k.idKlienta,k.Imie,k.Nazwisko from Rezerwacja r 
														inner join Klient k On r.idKlienta=k.idKlienta 
---
DROP VIEW IF EXISTS Free_Kajak
GO

Create View Free_Kajak AS
Select * from Kajak
WHERE DataZwrotu <=GETDATE();
---
DROP VIEW IF EXISTS Free_RowerWodny
GO

Create View Free_RowerWodny AS
Select * from RowerWodny
WHERE DataZwrotu <=GETDATE();
---
DROP VIEW IF EXISTS Free_Grill
GO

Create View Free_Grill AS
Select * from Grill
WHERE DataZwrotu <=GETDATE();
---
DROP VIEW IF EXISTS Current_Dodatki
GO

Create View Current_Dodatki AS
SELECT * From Dodatki
---
DROP VIEW IF EXISTS Occup_Pole
GO

Create View Occup_Pole AS
SELECT r.DataRezerwacji,r.DataZwolnienia,p.idPola,p.RodzajPola FROM Rezerwacja r inner join Pole p on r.idPola = p.idPola
Where r.DataZwolnienia > GETDATE();
---
select * from Occup_Pole

DROP PROCEDURE IF EXISTS ShowKlientHistory
GO

CREATE PROCEDURE ShowKilentHistory @id int AS
SELECT * From Rezerwacja WHERE idKlienta = @id
GO
---
DROP PROCEDURE IF EXISTS ShowEmplyeeHistory
GO

CREATE PROCEDURE ShowEmplyeeHistory @id int AS
SELECT * From Rezerwacja WHERE idPracownika = @id
GO
---

DROP PROCEDURE IF EXISTS p_Rezerwacje
GO

CREATE PROCEDURE p_Rezerwacje @Date DATE AS
SELECT * FROM Rezerwacja 
WHERE @Date BETWEEN DataRezerwacji AND DataZwolnienia;
GO
---
DROP PROCEDURE IF EXISTS p_ClientLogin
GO

CREATE PROCEDURE p_ClientLogin @Login varchar(40) ,@Haslo varchar(50) AS
SELECT * FROM Klient
WHERE @Login = Login AND @Haslo = Password
GO
---
DROP PROCEDURE IF EXISTS p_StaffLogin
GO

CREATE PROCEDURE p_StaffLogin @Login varchar(40) ,@Haslo varchar(50) AS
SELECT * FROM Pracownik
WHERE @Login = Login AND @Haslo = Password
GO
---
exec p_ClientLogin @login=Kubag,@haslo = kbg;

