-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости
-- от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

USE semimar_4;

-- создание функции (не работает пока не отключено бинарное логирование:
-- в файле my.ini добавил запись skip_log_bin = true и перезапустил сервер)
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
    RETURNS VARCHAR(15) NOT DETERMINISTIC
    BEGIN
        DECLARE greeting VARCHAR(15);
        IF (current_time() > '00:00:00' AND current_time() <= '06:00:00')
            THEN SET greeting = 'Доброй ночи';
        END IF;
        IF (current_time() > '06:00:00' AND current_time() <= '12:00:00')
            THEN SET greeting = 'Доброе утро';
        END IF;
        IF (current_time() > '12:00:00' AND current_time() <= '18:00:00')
            THEN SET greeting ='Добрый день';
        END IF;
        IF (current_time() > '18:00:00' AND current_time() <= '00:00:00')
            THEN SET greeting = 'Добрый вечер';
        END IF;
        RETURN greeting;
    END //
DELIMITER ;

-- использование
SELECT hello();