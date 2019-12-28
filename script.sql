CREATE TABLE IF NOT EXISTS "Regions" ( "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,	"region_name" TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS "Cities" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"city_name"	TEXT NOT NULL,
	"region_id"	INTEGER,
	FOREIGN KEY("region_id") REFERENCES "Regions"("id") ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE TABLE IF NOT EXISTS "Comments" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"last_name"	TEXT NOT NULL,
	"first_name"	TEXT NOT NULL,
	"third_name"	TEXT,
	"phone"	TEXT,
	"email"	TEXT,
	"comment"	TEXT NOT NULL,
	"city_id"	INTEGER NOT NULL,
	"region_id"	INTEGER,
	FOREIGN KEY("city_id") REFERENCES "Cities"("id") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("region_id") REFERENCES "Regions"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Regions (region_name) SELECT 'Краснодарский край' WHERE NOT EXISTS(SELECT 1 FROM Regions WHERE region_name = 'Краснодарский край');
INSERT INTO Regions (region_name) SELECT 'Ростовская область' WHERE NOT EXISTS(SELECT 1 FROM Regions WHERE region_name = 'Ростовская область');
INSERT INTO Regions (region_name) SELECT 'Ставропольский край' WHERE NOT EXISTS(SELECT 1 FROM Regions WHERE region_name = 'Ставропольский край');

INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Краснодарский край'), 'Краснодар' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Краснодарский край') AND city_name = 'Краснодар');
INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Краснодарский край'), 'Кропоткин' 
WHERE NOT EXISTS(SELECT 2 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Краснодарский край') AND city_name = 'Кропоткин');
INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Краснодарский край'), 'Славянск' 
WHERE NOT EXISTS(SELECT 3 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Краснодарский край') AND city_name = 'Славянск');

INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Ставропольский край'), 'Ставрополь' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Ставропольский край') AND city_name = 'Ставрополь');
INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Ставропольский край'), 'Пятигорск' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Ставропольский край') AND city_name = 'Пятигорск');
INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Ставропольский край'), 'Кисловодск' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Ставропольский край') AND city_name = 'Кисловодск');

INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Ростовская область'), 'Ростов' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Ростовская область') AND city_name = 'Ростов');
INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Ростовская область'), 'Шахты' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Ростовская область') AND city_name = 'Шахты');
INSERT INTO Cities(region_id,city_name) 
SELECT (SELECT id FROM Regions WHERE region_name = 'Ростовская область'), 'Батайск' 
WHERE NOT EXISTS(SELECT 1 FROM Cities WHERE region_id = (SELECT id FROM Regions WHERE region_name = 'Ростовская область') AND city_name = 'Батайск');




INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_1', 'Юзер_1', 'Юзерович_1', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Краснодар' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_2', 'Юзер_2', 'Юзерович_2', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Краснодар' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_3', 'Юзер_3', 'Юзерович_3', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Краснодар' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_4', 'Юзер_4', 'Юзерович_4', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Краснодар' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_5', 'Юзер_5', 'Юзерович_5', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Краснодар' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_6', 'Юзер_6', 'Юзерович_6', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Славянск' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_7', 'Юзер_7', 'Юзерович_7', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Кропоткин' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Краснодарский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_8', 'Юзер_8', 'Юзерович_8', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ставрополь' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ставропольский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_9', 'Юзер_9', 'Юзерович_9', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ставрополь' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ставропольский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_10', 'Юзер_10', 'Юзерович_10', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Кисловодск' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ставропольский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_11', 'Юзер_11', 'Юзерович_11', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Пятигорск' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ставропольский край' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_12', 'Юзер_12', 'Юзерович_12', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ростов' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ростовская область' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_13', 'Юзер_13', 'Юзерович_13', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ростов' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ростовская область' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_14', 'Юзер_14', 'Юзерович_14', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ростов' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ростовская область' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_15', 'Юзер_15', 'Юзерович_15', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ростов' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ростовская область' LIMIT 1));
INSERT INTO "Comments"
("last_name", "first_name", "third_name", "phone", "email", "comment","city_id","region_id")
VALUES ('Юзеров_16', 'Юзер_16', 'Юзерович_16', '+79999999999', 'user@user.us', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut, modi?', (SELECT id FROM Cities WHERE city_name = 'Ростов' LIMIT 1), (SELECT id FROM Regions WHERE region_name = 'Ростовская область' LIMIT 1));