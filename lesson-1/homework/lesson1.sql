
--Task 1
" Data – bu faktlar yoki ma'lumotlar; masalan, raqamlar, matnlar yoki o'lchovlar.

Database – bu ma'lumotlarni tartib bilan saqlaydigan tizim; masalan, mijozlar ro'yxati.

Relational database – bu ma'lumotlarni bog'langan jadvallar ko‘rinishida saqlaydigan baza; masalan, xaridorlar va ularning buyurtmalari aloqada bo‘ladi.

Table – bu ma'lumotlarni satr (row) va ustun (column)larda saqlaydigan strukturadir; masalan, “Talabalar” jadvali. "


--Task 2
" SQL Serverning 5 ta asosiy xususiyati:

1. Data Management – katta hajmdagi ma'lumotlarni saqlash, boshqarish va oson izlash imkonini beradi.


2. Security – ma'lumotlarni parol, foydalanuvchi ruxsatlari bilan himoya qiladi.


3. Backup and Recovery – ma'lumotlarni avtomatik saqlab qo‘yish va tiklash imkoniyatiga ega.


4. Stored Procedures & Triggers – takrorlanuvchi ishlarni avtomatlashtirishga yordam beradi.


5. Scalability & Performance – kichikdan katta tizimlargacha samarali ishlay oladi."


--Task 3
"SQL Serverda asosiy 2 ta autentifikatsiya (kirish) usuli mavjud:

1. Windows Authentication – foydalanuvchi Windows tizimi orqali kiradi. Bu usul xavfsiz va ko‘p ishlatiladi.


2. SQL Server Authentication – foydalanuvchi SQL Server uchun alohida login va parol kiritadi.



Ikkalasining kombinatsiyasini ham qo‘llab-quvvatlaydi. Bu holatga Mixed Mode Authentication deyiladi."


--Task 4
CREATE DATABASE SchoolDB

--Task 5
CREATE TABLE Students (
StudentsID INT PRIMARY KEY,
Name Varchar(50),
Age INT);

--Task 6
"SQL Server, SSMS, va SQL o'rtasidagi farqlar:

1. SQL Server:
Microsoft tomonidan ishlab chiqilgan ma'lumotlar bazasini boshqarish tizimi (DBMS).
Vazifasi: Ma'lumotlarni saqlash, boshqarish, va qayta ishlash uchun ishlatiladi. Bu serverda barcha ma'lumotlar va ma'lumotlar bazalari joylashadi.

2. SSMS (SQL Server Management Studio):
SQL Serverni boshqarish uchun ishlatiladigan grafik interfeys (GUI) dasturi.
Vazifasi: SQL Serverga ulanish, ma'lumotlar bazasini yaratish, tahrirlash, va so‘rovlar bajarish uchun qulay vosita. Bu SQL Serverning administratorlik va rivojlantirish vositasi.

3. SQL (Structured Query Language):

Ma'lumotlar bazalari bilan ishlash uchun ishlatiladigan so‘rovlar tili.
Vazifasi: Ma'lumotlarni yaratish, o‘zgartirish, o‘qish va o‘chirish uchun ishlatiladi. SQL Serverda ma'lumotlar bilan ishlash uchun SQL sintaksisi va buyruqlari yoziladi.

Farqlari:
SQL Server — ma'lumotlar bazasini boshqaradigan tizim.
SSMS — SQL Serverni boshqarish uchun dastur.
SQL — SQL Serverda ma'lumotlar bilan ishlash uchun ishlatiladigan til."


--Task 7
"1. DQL (Data Query Language):
Ma'lumotlarni so‘rash uchun ishlatiladi.
Misol: SELECT * FROM Employees;

2. DML (Data Manipulation Language):
Ma'lumotlarni qo‘shish, o‘zgartirish va o‘chirish uchun ishlatiladi.
Misollar:
INSERT INTO Employees (id, name) VALUES (1, 'John');
UPDATE Employees SET name = 'Jane' WHERE id = 1;
DELETE FROM Employees WHERE id = 1;


3. DDL (Data Definition Language):
Ma'lumotlar bazasining strukturasini yaratish yoki o‘zgartirish uchun ishlatiladi.
Misollar:
CREATE TABLE Employees (...);
ALTER TABLE Employees ADD salary DECIMAL(10, 2);
DROP TABLE Employees;

4. DCL (Data Control Language):
Foydalanuvchilarga huquq berish yoki olish uchun ishlatiladi.
Misollar:
GRANT SELECT ON Employees TO UserName;
REVOKE INSERT ON Employees FROM UserName;

5. TCL (Transaction Control Language):
Tranzaksiyalarni boshqarish uchun ishlatiladi.
Misollar:
COMMIT;
ROLLBACK;
SAVEPOINT my_savepoint;


Har bir tur SQLda ma'lum bir vazifani bajaradi."

--Task 8
INSERT INTO Students VALUES
(1, 'Ali', 29),
(2, 'Vali', 31),
(3, 'Sali', 33);

--Task 9
"Quyidagi tartibda SSMSda zaxira olish va tiklashni amalga oshirishingiz mumkin:

A. Zaxira olish (Backup) SSMS orqali:

1. SSMSga kirish.


2. Object Explorerda Databases bo‘limidan SchoolDB ni tanlang.


3. SchoolDB ga o‘ng tugmani bosing va Tasks > Back Up ni tanlang.


4. Backup typeni Full (to‘liq) qilib tanlang.


5. Destination bo‘limida Disk ni tanlang va zaxira faylini saqlash joyini ko‘rsating (masalan, C:\Backup\SchoolDB.bak).


6. OK tugmasini bosing va zaxira olishni yakunlang."



B. Zaxiradan tiklash (Restore) SSMS orqali:

1. SSMSga kirish.


2. Object Explorerda Databases bo‘limiga o‘ng tugmani bosing va Restore Database ni tanlang.


3. Source bo‘limida Device ni tanlab, zaxira faylini (masalan, C:\Backup\SchoolDB.bak) tanlang.


4. OK tugmasini bosing va tiklashni amalga oshiring.
