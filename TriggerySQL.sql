CREATE TRIGGER Correct_Date_For_Kajak ON Kajak
FOR UPDATE,INSERT
AS
DECLARE @DW AS date, @DZ AS date;
BEGIN
SET @DW = (SELECT TOP 1 DataWynajmu FROM inserted);
SET @DZ = (SELECT TOP 1 DataZwrotu FROM inserted);
IF (@DW > @DZ)
BEGIN
	Print('Data Wynajmu powinna być mniejsza bądź równa Dacie Zwrotu')
	rollback
END
END


CREATE TRIGGER Correct_Date_For_RowerWodny ON RowerWodny
FOR UPDATE,INSERT
AS
DECLARE @DW AS date, @DZ AS date;
BEGIN
SET @DW = (SELECT TOP 1 DataWynajmu FROM inserted);
SET @DZ = (SELECT TOP 1 DataZwrotu FROM inserted);
IF (@DW > @DZ)
BEGIN
	Print('Data Wynajmu powinna być mniejsza bądź równa Dacie Zwrotu')
	rollback
END
END

CREATE TRIGGER Correct_Date_For_Grill ON Grill
FOR UPDATE, INSERT
AS
DECLARE @DW AS date, @DZ AS date;
BEGIN
SET @DW = (SELECT TOP 1 DataWynajmu FROM inserted);
SET @DZ = (SELECT TOP 1 DataZwrotu FROM inserted);
IF (@DW > @DZ)
BEGIN
	Print('Data Wynajmu powinna być mniejsza bądź równa Dacie Zwrotu')
	rollback
END
END



CREATE TRIGGER Correct_Date_For_Rezerwacja ON Rezerwacja
FOR INSERT
AS
DECLARE @DW AS date, @DZ AS date;
BEGIN
SET @DW = (SELECT TOP 1 DataRezerwacji FROM inserted);
SET @DZ = (SELECT TOP 1 DataZwolnienia FROM inserted);
IF (@DW >= @DZ)
BEGIN
	Print('Data rezerwacji powinna być mniejsza od daty zwolnienia')
	rollback
END
END

CREATE TRIGGER Free_Pole ON Rezerwacja
FOR INSERT
AS
DECLARE @Id As INT,@DW AS DATE, @DZ AS DATE
BEGIN
SET @Id=(SELECT TOP 1 idPola From inserted)
SET @DW=(Select TOP 1 DataRezerwacji FROM inserted)
SET @DZ=(SELECT DataZwolnienia From Rezerwacja WHERE idPola = @Id)
IF(@DW<=@DZ)
BEGIN
PRINT('Pole jest juz zajete w tym terminie')
Rollback
END
END
