--Исходные данные.
--База данных test содержит две таблицы. Таблица Authors имеет следующую структуру:
-- идентификатор автора, представленный целым числом, является первичным ключом таблицы;
-- поле с именем и фамилией автора длиной до 64 символов включительно, которое не может быть пустым;
-- поле примечания длиной до 255 символов включительно.
--Данная таблица содержит данные:
--1, 'Arnold Grey', -
--2, 'Tom Hawkins', 'new author'
--3, 'Jim Beam',
CREATE TABLE Authors (
	id INT PRIMARY KEY NOT NULL,
        fullName VARCHAR(64) NOT NULL,
        comments VARCHAR(255)
        );
--Таблица Documents имеет следующую структуру:
-- идентификатор документа, представленный целым числом, является первичным ключом таблицы;
-- поле названия документа длиной до 64 символов включительно, которое не может быть пустым;
-- поле с основным текстом документа длиной до 1024 символов включительно;
-- поле даты создания документа, которое должно быть обязательно заполнено;
-- поле ссылки на автора документа, которое является внешним ключом, ссылающимся на первичный ключ таблицы Authors, и которое также не может быть пустым.
--Данная таблица содержит данные:
--1, 'Project plan', 'First content', 1
--2, 'First report', 'Second content', 2
--3, 'Test result', 'Third content', 2
--4, 'Second report', 'Report content', 3

CREATE TABLE Documents (id INTEGER PRIMARY KEY,
                        title VARCHAR(64) NOT NULL,
                        text VARCHAR(1024),
                        createDate DATE NOT NULL,
                        idAuthor INTEGER NOT NULL,
                        CONSTRAINT conAuthId FOREIGN KEY (idAuthor) REFERENCES authors(id)
                        );

--Для данных таблиц.
--1. Напишите последовательность операторов SQL (SQL-скрипт), которая создаёт указанные таблицы и заполняет их вышеуказанными данными.

INSERT INTO Authors (id, fullName, comments) VALUES
                    (1, 'Arnold Grey', NULL),
                    (2, 'Tom Hawkins', 'new author'),
                    (3, 'Jim Beam', NULL);


INSERT INTO Documents (id, title, text, createDate, idAuthor) VALUES
                      (1, 'Project plan', 'First content', '2020-11-01', 1),
                      (2, 'First report', 'Second content', '2021-03-25', 2),
                      (3, 'Test result', 'Third content', '2021-07-12', 2),
                      (4, 'Second report', 'Report content','2021-10-04', 3);


--2. Напишите оператор UPDATE, который в таблице авторов все пустые (null) комментарии заменяет на строку 'No data'.
UPDATE Authors SET comments = 'No data' WHERE (comments IS NULL);

--3. Напишите оператор SELECT, который запрашивает названия всех документов, автором которых является Tom Hawkins.
SELECT Documents.title
FROM Documents LEFT JOIN Authors ON Documents.idAuthor = Authors.id
WHERE Authors.fullname = 'Tom Hawkins';

--4. Напишите оператор SELECT, который запрашивает идентификатор, название документа и его автора, при условии, что в названии документа есть слово report.

SELECT Documents.id, Documents.title, Authors.fullname
FROM Documents LEFT JOIN Authors ON Documents.idAuthor = Authors.id
WHERE Documents.title LIKE ('%report%');
