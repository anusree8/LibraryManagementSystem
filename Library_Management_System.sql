create database library;
use library;
create table Branch(Branch_no int PRIMARY KEY,
Manager_Id int,
Branch_address varchar(30),
Contact_no bigint);

insert into Branch values(1,110,'TVPM',9847295184),
(2,111,'Kollam',9847295123),
(3,112,'Alleppey',9847295124),
(4,113,'Pathanamthitta',9847293645),
(5,114,'Kottayam',9847296541),
(6,115,'Ernakulam',9847265417);
select * from Branch;

create table Employee(Emp_Id int primary key,
Branch_no int,
Emp_name varchar(30),
Position varchar(40),
Salary decimal(7,2),
foreign key (Branch_no) references Branch(Branch_no));

insert into Employee values (110,1,'Kavya','Librarian',55000.00),
(111,2,'Meera','Assistant',45000.00),
(112,3,'Deva','Clerk',30000.00),
(113,4,'Hari','Librarian',55000.00),
(114,5,'Jeeva','Clerk',30000.00),
(115,6,'Anu','Librarian',55000.00),
(116,2,'Oviya','Assistant',45000.00);
select * from Employee;

create table Customer (Customer_Id int PRIMARY KEY,
Customer_name varchar(40),
Customer_address varchar(50),
Reg_date date);
 
 insert into Customer values(01,'Neethu','Neethu bhavan','2020-02-13'),
 (02,'Vijay','Thiruvathira','2021-06-23'),
 (03,'Ganesh','Shivadham','2020-12-08'),
 (04,'Anitha','Anitha bhavan','2019-02-13'),
 (05,'Greeshma','GG nivas','2020-12-23'),
 (06,'Appu','Nandhanam','2019-02-13'),
 (07,'Ammu','Nandhanam','2020-02-22'),
 (08,'Veena','Veena bhavan','2020-02-13'),
 (09,'Jaya','Puthazhikathi','2022-02-13'),
 (10,'Jithu','Puthazhikathi','2021-10-10');
  select * from Customer;
 
 create table Books(ISBN varchar(100) PRIMARY KEY,
Book_title  varchar(50),
Category varchar(60),
Rental_Price decimal(6,3),
Status varchar(30),
Author varchar(30),
Publisher varchar(30));

insert into Books values('ISBN01','Randamoozham','Classics',150.000,'Yes','M.T.Vasudevan','AK Publisher'),
('ISBN02','Pathummayude Aadu','Comic novel',200.000,'Yes','Vaikom Muhammad Basheer','DC Publisher'),
('ISBN03','Kayar','Novel',150.000,'No','Thakazhi','AK Publisher'),
('ISBN04','Chemmeen','Romance',200.000,'Yes','Thakazhi','National Publisher'),
('ISBN05','Ente katha','Autobiography',350.000,'Yes','Madhavikutty','National Publisher'),
('ISBN06','Aatujeevitham','Fiction',250.000,'Yes','Benyamin','DC Publisher'),
('ISBN07','Naalukettu','Novel',150.000,'No','M.T.Vasudevan','AK Publisher');
select * from Books;
 
 create table IssueStatus(Issue_Id int PRIMARY KEY,
Issued_cust int,
Issued_book_name varchar(40),
Issue_date date,
Isbn_book varchar(100),
foreign key (Issued_cust) references Customer(Customer_Id),
foreign key (Isbn_book) references Books(ISBN));

insert into IssueStatus values(1001,01,'Randamoozham','2020-03-13','ISBN01'),
(1002,03,'Aatujeevitham','2021-02-13','ISBN06'),
(1003,04,'Ente katha','2020-02-15','ISBN05'),
(1004,09,'Pathummayude Aadu','2022-12-13','ISBN02'),
(1005,05,'Chemmeen','2021-03-23','ISBN04');
select * from IssueStatus;

create table ReturnStatus(Return_Id int PRIMARY KEY, 
Return_cust int,
Return_book_name varchar(100),
Return_date date,
Isbn_book2 varchar(100),
foreign key (Isbn_book2) references Books(ISBN));

insert into ReturnStatus values(210,01,'Randamoozham','2021-03-13','ISBN01'),
(211,03,'Aatujeevitham','2022-02-13','ISBN06'),
(212,04,'Ente katha','2021-02-15','ISBN05'),
(213,05,'Chemmeen','2023-03-03','ISBN04'),
(214,09,'Pathummayude Aadu','2023-03-10','ISBN02');
select * from ReturnStatus;

-- 1.Retrieve the book title, category, and rental price of all available books.

select Book_title,Category,Rental_Price from Books where Status='Yes';

-- 2.List the employee names and their respective salaries in descending order of salary. 

select Emp_name,Salary from Employee order by Salary desc;

-- 3.Retrieve the book titles and the corresponding customers who have issued those books.

select Books.Book_title,Customer.Customer_name from IssueStatus i join Books on
 i.isbn_book=Books.ISBN join Customer on i.Issued_cust=Customer.Customer_id;
 
 -- 4.Display the total count of books in each category. 
 
 select count(*) from Books group by Category;
 
 -- 5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
 
 select Emp_name,Position from Employee where Salary > 50000.00;
 
 -- 6.List the customer names who registered before 2022-01-01 and have not issued any books yet.
 
 select Customer_name from Customer c join IssueStatus i 
 on c.Customer_Id=i.Issued_cust where Issue_date < '2022-01-01';

-- 7.Display the branch numbers and the total count of employees in each branch. 

select Branch_no,count(*) from Employee group by Branch_no;

-- 8.Display the names of customers who have issued books in the month of June 2023. 

select Customer_name from Customer join IssueStatus i on Customer.Customer_Id=i.Issued_cust
where month(Issue_date)=6 and year(Issue_date)=2023;

-- 9.Retrieve book_title from book table containing history. 

select Book_title from Books where Category='History';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

select Branch_no,count(*) from Employee group by Branch_no having count(*) > 5;

