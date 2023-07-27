-- Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой
-- можно переместить (не скопировать?) любого (одного) пользователя из таблицы users в таблицу users_old.
-- (использование транзакции с выбором commit или rollback – обязательно).

USE semimar_4;

-- создание таблицы users_old
DROP TABLE IF EXISTS user_old;
CREATE TABLE user_old(
id BIGINT UNSIGNED PRIMARY KEY NOT NULL UNIQUE,
firstname VARCHAR(50),
lastname VARCHAR(50),
email VARCHAR(120) UNIQUE) COMMENT = 'Копия таблицы users';

-- создание процедуры
DELIMITER //
DROP PROCEDURE IF EXISTS transfer;
CREATE PROCEDURE transfer(rand_id INT)
BEGIN
    START TRANSACTION;
        INSERT INTO users_old SELECT * FROM users AS u WHERE u.id = rand_id;
        DELETE FROM users AS u WHERE u.id = rand_id;
    COMMIT;
END //
DELIMITER ;

-- использование
CALL transfer( @rand_id := (SELECT id FROM users ORDER BY rand() LIMIT 1));
SELECT @rand_id;
SELECT * FROM users_old;
SELECT * FROM users;