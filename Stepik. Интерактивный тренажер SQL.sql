drop DATABASE IF EXISTS Interactive_SQL_Trainer;
CREATE DATABASE Interactive_SQL_Trainer;
USE Interactive_SQL_Trainer;

CREATE TABLE IF NOT EXISTS genre
(
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS book
(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

INSERT genre(name_genre)
    VALUES ('Роман');

INSERT book(title, author, price, amount)
    VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3);

INSERT book(title, author, price, amount)
    VALUES ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
            ('Идиот', 'Достоевский Ф.М.', 460.00, 10),
            ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2),
           ('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);

SELECT * FROM book;

SELECT book.author, book.title, book.price FROM book;

SELECT book.title AS 'Название', book.author AS 'Автор' from book;

# Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек.
# Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги).
# В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack.
SELECT book.title, book.amount, book.amount * 1.65 AS pack FROM book;

# В конце года цену каждой книги на складе пересчитывают – снижают ее на 30%. Написать SQL запрос, который
# из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. Столбец с новой ценой
# назвать new_price, цену округлить до 2-х знаков после запятой.
SELECT book.title, book.author, book.amount, ROUND(book.price * 0.7, 2) AS new_price FROM book;

# При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором
# месте книги Сергея Есенина. Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%.
# Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price.
# Значение округлить до двух знаков после запятой.
SELECT book.author, book.title,
    ROUND(
            IF(book.author = 'Булгаков М.А.', book.price * 1.1,
               IF(book.author = 'Есенин С.А.', book.price * 1.05, price)
            )
    ,2) AS new_price
    FROM book;

# Вывести автора, название  и цены тех книг, количество которых меньше 10.
SELECT book.author, book.title, book.price
    FROM book
    WHERE amount < 10;

# Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600,
# а стоимость всех экземпляров этих книг больше или равна 5000.
SELECT book.title, book.author, book.price, book.amount
    FROM book
    WHERE (price < 500 OR price > 600) AND price * amount >= 5000;

# Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),
# а количество или 2, или 3, или 5, или 7.
SELECT book.title, book.author
    FROM book
    WHERE price BETWEEN 540.50 AND 800 AND amount IN (2, 3, 5, 7);