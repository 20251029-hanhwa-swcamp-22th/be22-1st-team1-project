CREATE USER 'carrotgo'@'%' IDENTIFIED BY  'carrotgo';

SHOW DATABASES;

USE mysql;

SELECT * FROM user;

CREATE DATABASE carrotgodb;

SHOW DATABASES;

SHOW GRANTS FOR 'carrotgo'@'%';

GRANT ALL PRIVILEGES ON carrotgodb.* TO 'carrotgo'@'%';