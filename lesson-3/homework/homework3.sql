--HOMEWORK LESSON 3

--TASK 1
"Define:
 BULK INSERT bu SQL Server'dagi buyruq bo‘lib, tashqi
fayldan (odatda .txt yoki .csv formatdagi) katta hajmdagi
ma'lumotlarni jadvalga tez va samarali tarzda yuklash uchun ishlatiladi.

Purpose (maqsadi):
Bu buyruq orqali foydalanuvchi qo‘lda birma-bir ma’lumot kiritib
o‘tirmasdan, bitta komandada minglab yoki millionlab satrli ma’lumotni
tezda bazaga yuklay oladi. Bu ayniqsa katta hajmli fayllar bilan ishlaganda
vaqtni tejaydi"


--TASK 2
/*1. CSV (Comma-Separated Values) — Eng keng tarqalgan fayl turi.
2. TXT (Plain Text File) — Oddiy matn fayli.
3. XLS / XLSX (Excel fayllari) — Excel jadval fayllari.
4. XML (eXtensible Markup Language) — Ma’lumotlar tuzilmasi saqlanadigan fayl.*/


--Task 3
CREATE DATABASE HOMEWORKS
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(50),
	Price DECIMAL(10,2)
);
SELECT * FROM Products;

--Task 4
INSERT INTO Products
VALUES (1, 'Apple', 5000),
	(2, 'Banana', 12000),
	(3, 'Mango', 10000);

--Task 5
--EXAMPLE:
CREATE TABLE Students (
	ID INT,
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NULL
);

/*AGAR SHU SHART BILAN JADVAL TUZILSA Name ustunini bo'sh qoldirish imkonsiz bo'ladi,
chunki unga NOT NULL ya'ni noma'lum(NULL) bo'lishi mumkin emas degan shart berilgan.
Email ustunida esa NULL bo'lishi mumkin deb shart kiritildi, ya'ni Email ustuni tagidagi
qiymatlar bo'sh qoldirilishi mumkin va shunday qilinsa jadvalda NULL yozuvi chiqadi.*/


--Task 6
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName
UNIQUE (ProductName);

--Task 7
/*SQLda comment (izoh) yozishning asosiy vazifasi —
kodni tushunarliroq qilish. Bu, ayniqsa, bir nechta odam 
ishlayotgan loyihalarda yoki murakkab so‘rovlar yozilganda juda foydali.
SQLda commentlar quyidagicha ishlatiladi:

1. Bir qatorlik comment — -- bilan yoziladi:

-- Bu yerda foydalanuvchilar jadvalidan ma'lumot olinmoqda
SELECT * FROM users;

2. Ko‘p qatorli comment — /* ... */ orasida yoziladi:
/* Bu query 
   foydalanuvchilarning 
   faollik darajasini hisoblaydi */
SELECT user_id, COUNT(*) FROM logins GROUP BY user_id;

Comment nima uchun kerak:
Kodni tushunishni osonlashtiradi
Murakkab SQL so‘rovlarining nima qilayotganini tushuntiradi
Test yoki vaqtincha o‘chirilgan kodni saqlab qo‘yish uchun ishlatiladi


Xullas, commentlar — bu kodga yozilgan tushuntirishlar, ular bajarilmaydi,
faqat o‘quvchi uchun. Kerakli joyda ishlatish yaxshi odat hisoblanadi.*/

--Task 8
CREATE TABLE Categories(
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(50) UNIQUE
);

--Task 9
/* SQL Serverda IDENTITY ustuni — bu avtomatik tarzda ortib boradigan raqam
saqlanadigan ustundir. Odatda uni asosiy kalit (Primary Key) sifatida ishlatishadi.

IDENTITY ustunining vazifasi:

1.Avtomatik raqam berish – Har yangi yozuv (row) qo‘shilganda SQL Server avtomatik
ravishda unga tartib raqami beradi. Siz bu ustunga qiymat kiritishingiz shart emas.

2.Unikal qiymatlar – Har bir satrga yagona (takrorlanmaydigan) raqam beriladi.
Bu esa yozuvlarni aniqlashda qulaylik yaratadi.

3. Ma’lumot kiritishni soddalashtiradi – Qo‘lda raqam kiritishga hojat qolmaydi, 
bu esa xatoliklarni kamaytiradi. */

--Task 10
bulk insert Products
from 'C:\Users\user\Desktop\a\Pr.txt'
with
(
firstrow=2,
fieldterminator=',',
rowterminator='\n'
)
SELECT * FROM Products;
drop table products

--Task 11
ALTER TABLE Products
ADD categoryID INT;
ALTER TABLE Products
ADD CONSTRAINT fk_category
FOREIGN KEY (categoryID)
REFERENCES Categories(CategoryID);

--TASK 12
/* PRIMARY KEY 1TA JADVALDA 1TA ISHLATILADI, UNIQUE ESA KO'P BOLISHI MUMKIN.
PRIMARY KEY- jadvaldagi har bir yozuvni noyob tarzda aniqlaydi
UNIQUE- ustundagi qiymatlarnig takrorlanmasligini ta'minlaydi.
PRIMARY KEY NULL QABUL QILMAYDI.
UNIQUE NULL QABUL QILISHI MUMKIN

CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
	Email VARCHAR(50) UNIQUE,
	NAME VARCHAR (50)
);
BU YERDA EmployeeID ustuni PRIMARY KEY bo'lib, takrorlanmaydi va NULL bo'lmaydi.
Email ustuni esa UNIQUE bo'lib, har bir ishchining emaili takrorlanmasligini taminlaydi
leik NULL qiymat qabul qilishi mumkin*/

--Task 13
ALTER TABLE Products
ADD CONSTRAINT chk_price
CHECK (Price > 0);

--Task 14
ALTER TABLE Products
ADD Stock INT NOT NULL
DEFAULT 0;

--Task 15
 
SELECT ProductID,
	ProductName,
	Price,
	ISNULL(categoryID, 0) AS CategoryNew,
	Stock
FROM Products;

SELECT *FROM Products

--Task 16
/*FOREIGN KEY constraints — SQL Serverda jadvaldagi ustunni boshqa jadvaldagi 
ustun bilan bog‘lab, ma’lumotlar yaxlitligini (integrity) ta’minlaydi.

Purpose (Maqsadi):
Bog‘lanish yaratish: Jadvaldagi ustun boshqa jadvaldagi ustun bilan bog‘liq bo‘ladi.
Ma’lumotlar yaxlitligini saqlash: Noto‘g‘ri yoki mavjud bo‘lmagan qiymatlarning 
kiritilishini oldini oladi.

Ma’lumotlarni avtomatik boshqarish: Masalan, ON DELETE CASCADE orqali
bog‘liq ma’lumotlar avtomatik o‘chiriladi.*/


--Jadval yaratishda qo‘llanishi:

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY
(CustomerID) REFERENCES Customers(CustomerID)
);

--Task 17
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
	Name VARCHAR(50),
	Age INT,
	CHECK (Age >=18)
);

--Task 18
CREATE TABLE Test3 (
	ID INT IDENTITY (100, 10));

--Task 19
CREATE TABLE OrderDetails (
	OrderID INT,
	ProductID INT,
	Quantity INT,
	PRIMARY KEY (OrderID, ProductID)
);

--Task 20

/* ISNULL funksiyasi NULL qiymatni boshqa qiymat bilan almashtiradi
example:
 
SELECT ISNULL(NULL,'APPLE')
Natija: APPLE

COALESCE funksiyasi berilgan qiymatlar orasidan birinchi NULL
bo'lmaganlarni qaytaradi. Example:

COALESCE(NULL, NULL, 'ABC', 123)
Natija: ABC

COALESCE birinchi bo'lib null bo'lmagan qiymatni qaytaradi.
ISNULL esa faqat ikkita qiymat bilan ishlaydi, COLESCE esa bir nechta qiymat bilan. */

--TASK 21
CREATE TABLE EmployeeS(
	EmpID INT PRIMARY KEY,
	Name VARCHAR(50),
	Email VARCHAR(50) UNIQUE
);

--Task 22
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	OrderDATE DATE,
	FOREIGN KEY (CustomerID)
REFERENCES
Customers(CustomerID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
