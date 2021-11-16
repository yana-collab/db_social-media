USE social_media_db;

/*            Представления         */
/*     Популярные темы в постах    */

CREATE VIEW popular_title AS
SELECT 
t.name,
COUNT(*) AS cnt
FROM titles t
JOIN users_posts up ON up.title_id = t.id 
GROUP BY t.name 
ORDER BY cnt DESC;

/*       Информация в профилях    */

CREATE VIEW profiles_information AS
SELECT 
p.user_id ,
CASE (p.gender)
WHEN 'M' THEN 'male'
WHEN 'F' THEN 'female'
WHEN 'X' THEN 'non-binary'
END AS gender,
at2.name AS animal_type,
c.name AS city
FROM profiles p 
JOIN animal_types at2 ON at2.id = p.animal_type_id 
JOIN cities c ON c.id = p.hometown_id
ORDER BY city;



/*               Процедура        */

DELIMITER //


DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
  CASE format
    WHEN 'date' THEN
      SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
    WHEN 'time' THEN
      SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
    WHEN 'secs' THEN
      SELECT UNIX_TIMESTAMP(NOW()) AS format_now;
    ELSE
      SELECT 'Ошибка в параметре format';
  END CASE;
END//

DELIMITER ;


/*      Триггер    */


CREATE TABLE social_media_db.history (
    id SERIAL PRIMARY KEY,
    deleted_message BIGINT UNSIGNED NOT NULL,
    createAt DATETIME NOT NULL DEFAULT NOW()
);

CREATE TRIGGER message_deleted
AFTER DELETE 
ON messages 
FOR EACH ROW 
INSERT INTO history (messages.id)
SELECT id
FROM DELETED;


