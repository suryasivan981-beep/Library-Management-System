
REATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);

create table users (
	user_id int primary key auto_increment,
    user_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15)
);

create table Transaction (
	transaction_id int primary key auto_increment,
    book_id int,
    user_id int,
    issue_date date not null,
    return_date date,
    status enum('issued', 'returned') default 'issued',
    
    foreign key (book_id) references books(book_id),
    foreign key (user_id) references users(user_id)
);
insert into books
(book_name,category, total_copies, available_copies,author)
 values
('java programming', 'programming' ,5,5,'james gosling'),
('python programming', 'programming',3,3,'guido van rossum'),
('database management','data base',4,4,'john smith');

insert into users
(user_name, email,phone)
 values
('surya', 'surya@gmail.com' ,'8248495615'),
('arun', 'arun@gmail.com','9876543211'),
('kumar','kumar@gmail.com','9876543212');

start transaction;

update books
set available_copies = available_copies -1
where book_id =1
and available_copies >0;

insert into transactions
(book_id, users_id, issue_date,status)
select 1, 1, curdate(), 'issued'
where row_count()=1;

commit; 

START TRANSACTION;

UPDATE Transactions
SET status = 'Returned',
    return_date = CURDATE()
WHERE transaction_id = 1
AND status = 'Issued';

UPDATE Books
SET available_copies = available_copies + 1
WHERE book_id = 1;

COMMIT;

SELECT * FROM Books;

SELECT * FROM Users;

SELECT
    Users.user_name,
    Books.book_name,
    Transactions.issue_date,
    Transactions.status
FROM Transactions
JOIN Users
ON Transactions.user_id = Users.user_id
JOIN Books
ON Transactions.book_id = Books.book_id
WHERE Transactions.status = 'Issued';


SELECT
    Users.user_name,
    Books.book_name,
    Transactions.issue_date,
    Transactions.return_date
FROM Transactions
JOIN Users
ON Transactions.user_id = Users.user_id
JOIN Books
ON Transactions.book_id = Books.book_id
WHERE Transactions.status = 'Returned';


SELECT book_name, author, available_copies
FROM Books
WHERE available_copies > 0;

SELECT
    Users.user_name,
    Books.book_name,
    Transactions.issue_date,
    Transactions.status
FROM Transactions
JOIN Users
ON Transactions.user_id = Users.user_id
JOIN Books
ON Transactions.book_id = Books.book_id
WHERE Transactions.status = 'Issued';
