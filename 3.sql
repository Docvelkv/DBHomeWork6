-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах
-- users, communities и messages в таблицу logs помещается время и дата создания записи,
-- название таблицы, идентификатор первичного ключа.

USE semimar_4;

-- Создание таблицы логирования
DROP TABLE IF EXISTS tb_logs;
CREATE TABLE tb_logs (
id INT PRIMARY KEY AUTO_INCREMENT,
time_creation TIMESTAMP,
tb_name VARCHAR(30),
tb_id_pk INT)
ENGINE = ARCHIVE
COMMENT = 'Логирование вставок в таблицы users, communities и messages';

-- создание триггеров
DELIMITER //
CREATE TRIGGER insert_users AFTER INSERT ON users FOR EACH ROW
BEGIN
    INSERT INTO tb_logs(time_creation, tb_name, tb_id_pk)
    VALUES(current_timestamp(), 'users', new.id);
END//

CREATE TRIGGER insert_communities AFTER INSERT ON communities FOR EACH ROW
BEGIN
    INSERT INTO tb_logs(time_creation, tb_name, tb_id_pk)
    VALUES(current_timestamp(), 'communities', new.id);
END//

CREATE TRIGGER insert_messages AFTER INSERT ON messages FOR EACH ROW
BEGIN
    INSERT INTO tb_logs(time_creation, tb_name, tb_id_pk)
    VALUES(current_timestamp(), 'messages', new.id);
END//
DELIMITER ;

-- вставка в таблицы и просмотр всех полей tb_logs
INSERT INTO users (id, firstname, lastname, email) VALUES
(11, "Lily", "Dennis", "junonu-goda96@outlook.com");

INSERT INTO communities (name) VALUES ("Urelielelens");

INSERT INTO messages(from_user_id, to_user_id, body, created_at)
VALUES(11, 6, "Another way to do this is to explicitly name the columns for which we want to insert data.
        This method can be used to insert fewer columns than in a table",  DATE_ADD(NOW(), INTERVAL 1 MINUTE));

SELECT * FROM tb_logs;