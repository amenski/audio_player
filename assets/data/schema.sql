/*
* DB script
* Run this script against database.db before running the app.
* The app will not execute any script, but copy the database.db on install
*/

-- ddl
BEGIN TRANSACTION;
CREATE TABLE "android_metadata" (
	"locale"	TEXT
);

CREATE TABLE IF NOT EXISTS "post" (
	"id"	INTEGER,
	"category_id"	INTEGER NOT NULL,
	"title"	TEXT NOT NULL,
	"url"	TEXT NOT NULL,
	"thumb_url"	TEXT,
	"description"	TEXT,
	"download_path" TEXT,
	"is_downloaded"	INTEGER NOT NULL DEFAULT 0,
	"is_opened"	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id, category_id)
);
CREATE TABLE IF NOT EXISTS "category" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"title"	TEXT NOT NULL,
	"description"	TEXT,
	"parent_category_id"	INTEGER,
	"thumb_url"	TEXT
);

CREATE TABLE IF NOT EXISTS "version" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"version" INTEGER not null
);
COMMIT;

BEGIN TRANSACTION
-- Locale metadata
INSERT INTO android_metadata("locale") VALUES("en_US");

-- categories
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("1", "በንባብ/ Audio books","በንባብ/ Audio books", NULL , "assets/images/reading-book.jpg");

-- PARENT-categories
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("20", "መጽሀፈ መነኮሳት ፊልክስዮስ","መጽሀፈ መነኮሳት ፊልክስዮስ", 1 , "assets/images/reading-book.jpg");
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("21", "ሃይማኖተ አበው","ሃይማኖተ አበው", 1 , "assets/images/reading-book.jpg");
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("23", "መጽሐፈ መነኮሳት አረጋዊ መንፈሳዊ","መጽሐፈ መነኮሳት አረጋዊ መንፈሳዊ ", 1 , "assets/images/reading-book.jpg");



-- posts
-- METSAFE_MENEKOSAT
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 1, 20, "መግቢያ ፩", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-1.mp3", "assets/images/reading-book.jpg", "መግቢያ ፩", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 2, 20, "መግቢያ ፪", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-2.mp3", "assets/images/reading-book.jpg", "መግቢያ ፪", NULL, 0, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 3, 20, "ክፍል 1", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/1.mp3", "assets/images/reading-book.jpg", "ክፍል 1", NULL, 0, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 4, 20, "ክፍል 2", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/2.mp3", "assets/images/reading-book.jpg", "ክፍል 2", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 5, 20, "ክፍል 3", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/3.mp3", "assets/images/reading-book.jpg", "ክፍል 3", NULL, 0, 0);
	
	
-- HAYMANOTE_ABEW
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 1, 21, "መቅድም", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3", "assets/images/reading-book.jpg", "መቅድም", NULL, 0, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 2, 21, "መግለጫ", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Meglecha.mp3", "assets/images/reading-book.jpg", "መግለጫ", NULL, 0, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 3, 21, "ታሪክ", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3", "assets/images/reading-book.jpg", "ታሪክ", NULL, 0, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 4, 21, "ምዕራፍ ፩", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/chapter1.mp3", "assets/images/reading-book.jpg", "ምዕራፍ ፩/Chapter 1", NULL, 0, 0);


-- 09/02/2020, የመምህር ግርማ ወንድሙ ስብከቶች  => http://www.radioabisinia.com/MemhirGirma/?C=M;O=A
ALTER TABLE POST ADD COLUMN PUB_DATE DATETIME;

INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("2", "መምህር ግርማ ወንድሙ","የመምህር ግርማ ወንድሙ ስብከቶች", NULL , "assets/images/aba-girma.jpg");
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("22", "Radio Abisinia","የመምህር ግርማ ወንድሙ ስብከቶች ", 2 , "assets/images/radio-abisinia.jpg");

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, PUB_DATE) 
	VALUES(1, 22, "Part 1", "http://www.radioabisinia.com/MemhirGirma/Saturday%20June%2016%202012%20Memhir%20Girma%20Part%201.mp3", "assets/images/aba-girma.jpg", "Part 1", NULL, 0, "2012-06-16");

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, PUB_DATE) 
	VALUES(2, 22, "Part 10", "http://www.radioabisinia.com/MemhirGirma/Saturday%20May%2023%202012%20Memhir%20Girma%20Part%2010.mp3", "assets/images/aba-girma.jpg", "Part 10", NULL, 0, "2012-06-23");

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, PUB_DATE) 
	VALUES(3, 22, "Part 11", "http://www.radioabisinia.com/MemhirGirma/Saturday%20June%2030%202012%20Memhir%20Girma%20Part%2011.mp3", "assets/images/aba-girma.jpg", "Part 11", NULL, 0, "2012-07-03");


-- 7/3/2020 METSAFE_MENEKOSAT - FILKSI'US
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
	VALUES( 6, 20, "ክፍል 4", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/4.mp3", "assets/images/reading-book.jpg", "ክፍል 4", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 7 , 20, "ክፍል 5 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/5.mp3", "assets/images/reading-book.jpg", "ክፍል 5", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 8 , 20, "ክፍል 6 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/6.mp3", "assets/images/reading-book.jpg", "ክፍል 6", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 9 , 20, "ክፍል 7 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/7.mp3", "assets/images/reading-book.jpg", "ክፍል 7", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 10, 20, "ክፍል 8 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/8.mp3", "assets/images/reading-book.jpg", "ክፍል 8", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 11, 20, "ክፍል 9 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/9.mp3", "assets/images/reading-book.jpg", "ክፍል 9", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 12, 20, "ክፍል 10", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/10.mp3", "assets/images/reading-book.jpg", "ክፍል 10", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 13, 20, "ክፍል 11", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/11.mp3", "assets/images/reading-book.jpg", "ክፍል 11", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 14, 20, "ክፍል 12", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/12.mp3", "assets/images/reading-book.jpg", "ክፍል 12", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 15, 20, "ክፍል 13", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/13.mp3", "assets/images/reading-book.jpg", "ክፍል 13", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 16, 20, "ክፍል 14", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/14.mp3", "assets/images/reading-book.jpg", "ክፍል 14", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 17, 20, "ክፍል 15", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/15.mp3", "assets/images/reading-book.jpg", "ክፍል 15", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 18, 20, "ክፍል 16", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/16.mp3", "assets/images/reading-book.jpg", "ክፍል 16", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 19, 20, "ክፍል 17", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/17.mp3", "assets/images/reading-book.jpg", "ክፍል 17", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 20, 20, "ክፍል 18", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/18.mp3", "assets/images/reading-book.jpg", "ክፍል 18", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 21, 20, "ክፍል 19", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/19.mp3", "assets/images/reading-book.jpg", "ክፍል 19", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 22, 20, "ክፍል 20", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/20.mp3", "assets/images/reading-book.jpg", "ክፍል 20", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 23, 20, "ክፍል 21", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/21.mp3", "assets/images/reading-book.jpg", "ክፍል 21", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 24, 20, "ክፍል 22", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/22.mp3", "assets/images/reading-book.jpg", "ክፍል 22", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 25 , 20, "ክፍል 23", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/23.mp3", "assets/images/reading-book.jpg", "ክፍል 23", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 26 , 20, "ክፍል 24", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/24.mp3", "assets/images/reading-book.jpg", "ክፍል 24", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 27 , 20, "ክፍል 25", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/25.mp3", "assets/images/reading-book.jpg", "ክፍል 25", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 28 , 20, "ክፍል 26", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/26.mp3", "assets/images/reading-book.jpg", "ክፍል 26", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 29 , 20, "ክፍል 27", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/27.mp3", "assets/images/reading-book.jpg", "ክፍል 27", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 30 , 20, "ክፍል 28", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/28.mp3", "assets/images/reading-book.jpg", "ክፍል 28", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 31 , 20, "ክፍል 29", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/29.mp3", "assets/images/reading-book.jpg", "ክፍል 29", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 32 , 20, "ክፍል 30", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/30.mp3", "assets/images/reading-book.jpg", "ክፍል 30", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 33 , 20, "ክፍል 31", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/31.mp3", "assets/images/reading-book.jpg", "ክፍል 31", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 34 , 20, "ክፍል 32", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/32.mp3", "assets/images/reading-book.jpg", "ክፍል 32", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 35 , 20, "ክፍል 33", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/33.mp3", "assets/images/reading-book.jpg", "ክፍል 33", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 36 , 20, "ክፍል 34", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/34.mp3", "assets/images/reading-book.jpg", "ክፍል 34", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 37 , 20, "ክፍል 35", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/35.mp3", "assets/images/reading-book.jpg", "ክፍል 35", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 38 , 20, "ክፍል 36", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/36.mp3", "assets/images/reading-book.jpg", "ክፍል 36", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 39 , 20, "ክፍል 37", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/37.mp3", "assets/images/reading-book.jpg", "ክፍል 37", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 40 , 20, "ክፍል 38", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/38.mp3", "assets/images/reading-book.jpg", "ክፍል 38", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 41 , 20, "ክፍል 39", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/39.mp3", "assets/images/reading-book.jpg", "ክፍል 39", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 42 , 20, "ክፍል 40", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/40.mp3", "assets/images/reading-book.jpg", "ክፍል 40", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 43 , 20, "ክፍል 41", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/41.mp3", "assets/images/reading-book.jpg", "ክፍል 41", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 44 , 20, "ክፍል 42", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/42.mp3", "assets/images/reading-book.jpg", "ክፍል 42", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 45 , 20, "ክፍል 43", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/43.mp3", "assets/images/reading-book.jpg", "ክፍል 43", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 46 , 20, "ክፍል 44", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/44.mp3", "assets/images/reading-book.jpg", "ክፍል 44", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 47 , 20, "ክፍል 45", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/45.mp3", "assets/images/reading-book.jpg", "ክፍል 45", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 48 , 20, "ክፍል 46", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/46.mp3", "assets/images/reading-book.jpg", "ክፍል 46", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 49 , 20, "ክፍል 47", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/47.mp3", "assets/images/reading-book.jpg", "ክፍል 47", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 50 , 20, "ክፍል 48", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/48.mp3", "assets/images/reading-book.jpg", "ክፍል 48", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 51 , 20, "ክፍል 49", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/49.mp3", "assets/images/reading-book.jpg", "ክፍል 49", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 52 , 20, "ክፍል 50", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/50.mp3", "assets/images/reading-book.jpg", "ክፍል 50", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 53 , 20, "ክፍል 51", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/51.mp3", "assets/images/reading-book.jpg", "ክፍል 51", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 54 , 20, "ክፍል 52", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/52.mp3", "assets/images/reading-book.jpg", "ክፍል 52", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 55 , 20, "ክፍል 53", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/53.mp3", "assets/images/reading-book.jpg", "ክፍል 53", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 56 , 20, "ክፍል 54", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/54.mp3", "assets/images/reading-book.jpg", "ክፍል 54", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 57 , 20, "ክፍል 55", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/55.mp3", "assets/images/reading-book.jpg", "ክፍል 55", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 58 , 20, "ክፍል 56", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/56.mp3", "assets/images/reading-book.jpg", "ክፍል 56", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 59 , 20, "ክፍል 57", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/57.mp3", "assets/images/reading-book.jpg", "ክፍል 57", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 60 , 20, "ክፍል 58", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/58.mp3", "assets/images/reading-book.jpg", "ክፍል 58", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 61 , 20, "ክፍል 59", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/59.mp3", "assets/images/reading-book.jpg", "ክፍል 59", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 62 , 20, "ክፍል 60", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/60.mp3", "assets/images/reading-book.jpg", "ክፍል 60", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 63 , 20, "ክፍል 61", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/61.mp3", "assets/images/reading-book.jpg", "ክፍል 61", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 64 , 20, "ክፍል 62", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/62.mp3", "assets/images/reading-book.jpg", "ክፍል 62", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 65 , 20, "ክፍል 63", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/63.mp3", "assets/images/reading-book.jpg", "ክፍል 63", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 66 , 20, "ክፍል 64", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/64.mp3", "assets/images/reading-book.jpg", "ክፍል 64", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 67 , 20, "ክፍል 65", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/65.mp3", "assets/images/reading-book.jpg", "ክፍል 65", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 68 , 20, "ክፍል 66", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/66.mp3", "assets/images/reading-book.jpg", "ክፍል 66", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 69 , 20, "ክፍል 67", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/67.mp3", "assets/images/reading-book.jpg", "ክፍል 67", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 70 , 20, "ክፍል 68", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/68.mp3", "assets/images/reading-book.jpg", "ክፍል 68", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 71 , 20, "ክፍል 69", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/69.mp3", "assets/images/reading-book.jpg", "ክፍል 69", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 72 , 20, "ክፍል 70", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/70.mp3", "assets/images/reading-book.jpg", "ክፍል 70", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 73 , 20, "ክፍል 71", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/71.mp3", "assets/images/reading-book.jpg", "ክፍል 71", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 74 , 20, "ክፍል 72", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/72.mp3", "assets/images/reading-book.jpg", "ክፍል 72", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 75 , 20, "ክፍል 73", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/73.mp3", "assets/images/reading-book.jpg", "ክፍል 73", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 76 , 20, "ክፍል 74", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/74.mp3", "assets/images/reading-book.jpg", "ክፍል 74", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 77 , 20, "ክፍል 75", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/75.mp3", "assets/images/reading-book.jpg", "ክፍል 75", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 78 , 20, "ክፍል 76", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/76.mp3", "assets/images/reading-book.jpg", "ክፍል 76", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 79 , 20, "ክፍል 77", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/77.mp3", "assets/images/reading-book.jpg", "ክፍል 77", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 80 , 20, "ክፍል 78", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/78.mp3", "assets/images/reading-book.jpg", "ክፍል 78", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 81 , 20, "ክፍል 79", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/79.mp3", "assets/images/reading-book.jpg", "ክፍል 79", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 82 , 20, "ክፍል 80", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/80.mp3", "assets/images/reading-book.jpg", "ክፍል 80", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 83 , 20, "ክፍል 81", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/81.mp3", "assets/images/reading-book.jpg", "ክፍል 81", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 84 , 20, "ክፍል 82", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/82.mp3", "assets/images/reading-book.jpg", "ክፍል 82", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 85 , 20, "ክፍል 83", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/83.mp3", "assets/images/reading-book.jpg", "ክፍል 83", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 86 , 20, "ክፍል 84", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/84.mp3", "assets/images/reading-book.jpg", "ክፍል 84", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 87 , 20, "ክፍል 85", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/85.mp3", "assets/images/reading-book.jpg", "ክፍል 85", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 88 , 20, "ክፍል 86", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/86.mp3", "assets/images/reading-book.jpg", "ክፍል 86", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 89 , 20, "ክፍል 87", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/87.mp3", "assets/images/reading-book.jpg", "ክፍል 87", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 90 , 20, "ክፍል 88", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/88.mp3", "assets/images/reading-book.jpg", "ክፍል 88", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 91 , 20, "ክፍል 89", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/89.mp3", "assets/images/reading-book.jpg", "ክፍል 89", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 92 , 20, "ክፍል 90", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/90.mp3", "assets/images/reading-book.jpg", "ክፍል 90", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 93 , 20, "ክፍል 91", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/91.mp3", "assets/images/reading-book.jpg", "ክፍል 91", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 94 , 20, "ክፍል 92", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/92.mp3", "assets/images/reading-book.jpg", "ክፍል 92", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 95 , 20, "ክፍል 93", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/93.mp3", "assets/images/reading-book.jpg", "ክፍል 93", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 96 , 20, "ክፍል 94", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/94.mp3", "assets/images/reading-book.jpg", "ክፍል 94", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 97 , 20, "ክፍል 95", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/95.mp3", "assets/images/reading-book.jpg", "ክፍል 95", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 98 , 20, "ክፍል 96", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/96.mp3", "assets/images/reading-book.jpg", "ክፍል 96", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 99 , 20, "ክፍል 97", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/97.mp3", "assets/images/reading-book.jpg", "ክፍል 97", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 100 , 20, "ክፍል 98", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/98.mp3", "assets/images/reading-book.jpg", "ክፍል 98", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 101 , 20, "ክፍል 99", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/99.mp3", "assets/images/reading-book.jpg", "ክፍል 99", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 102 , 20, "ክፍል 100", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/100.mp3", "assets/images/reading-book.jpg", "ክፍል 100", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 103 , 20, "ክፍል 101", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/101.mp3", "assets/images/reading-book.jpg", "ክፍል 101", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 104 , 20, "ክፍል 102", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/102.mp3", "assets/images/reading-book.jpg", "ክፍል 102", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 105 , 20, "ክፍል 103", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/103.mp3", "assets/images/reading-book.jpg", "ክፍል 103", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 106 , 20, "ክፍል 104", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/104.mp3", "assets/images/reading-book.jpg", "ክፍል 104", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 107 , 20, "ክፍል 105", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/105.mp3", "assets/images/reading-book.jpg", "ክፍል 105", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 108 , 20, "ክፍል 106", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/106.mp3", "assets/images/reading-book.jpg", "ክፍል 106", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 109 , 20, "ክፍል 107", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/107.mp3", "assets/images/reading-book.jpg", "ክፍል 107", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 110 , 20, "ክፍል 108", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/108.mp3", "assets/images/reading-book.jpg", "ክፍል 108", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 111 , 20, "ክፍል 109", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/109.mp3", "assets/images/reading-book.jpg", "ክፍል 109", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 112 , 20, "ክፍል 110", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/110.mp3", "assets/images/reading-book.jpg", "ክፍል 110", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 113 , 20, "ክፍል 111", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/111.mp3", "assets/images/reading-book.jpg", "ክፍል 111", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 114 , 20, "ክፍል 112", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/112.mp3", "assets/images/reading-book.jpg", "ክፍል 112", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 115 , 20, "ክፍል 113", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/113.mp3", "assets/images/reading-book.jpg", "ክፍል 113", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 116 , 20, "ክፍል 114", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/114.mp3", "assets/images/reading-book.jpg", "ክፍል 114", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 117 , 20, "ክፍል 115", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/115.mp3", "assets/images/reading-book.jpg", "ክፍል 115", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 118 , 20, "ክፍል 116", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/116.mp3", "assets/images/reading-book.jpg", "ክፍል 116", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 119 , 20, "ክፍል 117", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/117.mp3", "assets/images/reading-book.jpg", "ክፍል 117", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 120 , 20, "ክፍል 118", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/118.mp3", "assets/images/reading-book.jpg", "ክፍል 118", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 121 , 20, "ክፍል 119", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/119.mp3", "assets/images/reading-book.jpg", "ክፍል 119", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 122 , 20, "ክፍል 120", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/120.mp3", "assets/images/reading-book.jpg", "ክፍል 120", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 123 , 20, "ክፍል 121", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/121.mp3", "assets/images/reading-book.jpg", "ክፍል 121", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 124 , 20, "ክፍል 122", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/122.mp3", "assets/images/reading-book.jpg", "ክፍል 122", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 125 , 20, "ክፍል 123", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/123.mp3", "assets/images/reading-book.jpg", "ክፍል 123", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 126 , 20, "ክፍል 124", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/124.mp3", "assets/images/reading-book.jpg", "ክፍል 124", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 127 , 20, "ክፍል 125", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/125.mp3", "assets/images/reading-book.jpg", "ክፍል 125", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 128 , 20, "ክፍል 126", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/126.mp3", "assets/images/reading-book.jpg", "ክፍል 126", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 129 , 20, "ክፍል 127", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/127.mp3", "assets/images/reading-book.jpg", "ክፍል 127", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 130 , 20, "ክፍል 128", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/128.mp3", "assets/images/reading-book.jpg", "ክፍል 128", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 131 , 20, "ክፍል 129", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/129.mp3", "assets/images/reading-book.jpg", "ክፍል 129", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 132 , 20, "ክፍል 130", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/130.mp3", "assets/images/reading-book.jpg", "ክፍል 130", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 133 , 20, "ክፍል 131", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/131.mp3", "assets/images/reading-book.jpg", "ክፍል 131", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 134 , 20, "ክፍል 132", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/132.mp3", "assets/images/reading-book.jpg", "ክፍል 132", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 135 , 20, "ክፍል 133", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/133.mp3", "assets/images/reading-book.jpg", "ክፍል 133", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 136 , 20, "ክፍል 134", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/134.mp3", "assets/images/reading-book.jpg", "ክፍል 134", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 137 , 20, "ክፍል 135", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/135.mp3", "assets/images/reading-book.jpg", "ክፍል 135", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 138 , 20, "ክፍል 136", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/136.mp3", "assets/images/reading-book.jpg", "ክፍል 136", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 139 , 20, "ክፍል 137", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/137.mp3", "assets/images/reading-book.jpg", "ክፍል 137", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 140 , 20, "ክፍል 138", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/138.mp3", "assets/images/reading-book.jpg", "ክፍል 138", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 141 , 20, "ክፍል 139", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/139.mp3", "assets/images/reading-book.jpg", "ክፍል 139", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 142 , 20, "ክፍል 140", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/140.mp3", "assets/images/reading-book.jpg", "ክፍል 140", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 143 , 20, "ክፍል 141", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/141.mp3", "assets/images/reading-book.jpg", "ክፍል 141", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 144 , 20, "ክፍል 142", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/142.mp3", "assets/images/reading-book.jpg", "ክፍል 142", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 145 , 20, "ክፍል 143", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/143.mp3", "assets/images/reading-book.jpg", "ክፍል 143", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 146 , 20, "ክፍል 144", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/144.mp3", "assets/images/reading-book.jpg", "ክፍል 144", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 147 , 20, "ክፍል 145", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/145.mp3", "assets/images/reading-book.jpg", "ክፍል 145", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 148 , 20, "ክፍል 146", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/146.mp3", "assets/images/reading-book.jpg", "ክፍል 146", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 149 , 20, "ክፍል 147", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/147.mp3", "assets/images/reading-book.jpg", "ክፍል 147", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 150 , 20, "ክፍል 148", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/148.mp3", "assets/images/reading-book.jpg", "ክፍል 148", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 151 , 20, "ክፍል 149", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/149.mp3", "assets/images/reading-book.jpg", "ክፍል 149", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 152 , 20, "ክፍል 150", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/150.mp3", "assets/images/reading-book.jpg", "ክፍል 150", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 153 , 20, "ክፍል 151", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/151.mp3", "assets/images/reading-book.jpg", "ክፍል 151", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 154 , 20, "ክፍል 152", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/152.mp3", "assets/images/reading-book.jpg", "ክፍል 152", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 155 , 20, "ክፍል 153", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/153.mp3", "assets/images/reading-book.jpg", "ክፍል 153", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 156 , 20, "ክፍል 154", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/154.mp3", "assets/images/reading-book.jpg", "ክፍል 154", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 157 , 20, "ክፍል 155", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/155.mp3", "assets/images/reading-book.jpg", "ክፍል 155", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 158 , 20, "ክፍል 156", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/156.mp3", "assets/images/reading-book.jpg", "ክፍል 156", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 159 , 20, "ክፍል 157", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/157.mp3", "assets/images/reading-book.jpg", "ክፍል 157", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 160 , 20, "ክፍል 158", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/158.mp3", "assets/images/reading-book.jpg", "ክፍል 158", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 161 , 20, "ክፍል 159", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/159.mp3", "assets/images/reading-book.jpg", "ክፍል 159", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 162 , 20, "ክፍል 160", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/160.mp3", "assets/images/reading-book.jpg", "ክፍል 160", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 163 , 20, "ክፍል 161", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/161.mp3", "assets/images/reading-book.jpg", "ክፍል 161", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 164 , 20, "ክፍል 162", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/162.mp3", "assets/images/reading-book.jpg", "ክፍል 162", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 165 , 20, "ክፍል 163", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/163.mp3", "assets/images/reading-book.jpg", "ክፍል 163", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 166 , 20, "ክፍል 164", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/164.mp3", "assets/images/reading-book.jpg", "ክፍል 164", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 167 , 20, "ክፍል 165", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/165.mp3", "assets/images/reading-book.jpg", "ክፍል 165", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 168 , 20, "ክፍል 166", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/166.mp3", "assets/images/reading-book.jpg", "ክፍል 166", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 169 , 20, "ክፍል 167", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/167.mp3", "assets/images/reading-book.jpg", "ክፍል 167", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 170 , 20, "ክፍል 168", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/168.mp3", "assets/images/reading-book.jpg", "ክፍል 168", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 171 , 20, "ክፍል 169", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/169.mp3", "assets/images/reading-book.jpg", "ክፍል 169", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 172 , 20, "ክፍል 170", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/170.mp3", "assets/images/reading-book.jpg", "ክፍል 170", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 173 , 20, "ክፍል 171", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/171.mp3", "assets/images/reading-book.jpg", "ክፍል 171", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 174 , 20, "ክፍል 172", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/172.mp3", "assets/images/reading-book.jpg", "ክፍል 172", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 175 , 20, "ክፍል 173", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/173.mp3", "assets/images/reading-book.jpg", "ክፍል 173", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 176 , 20, "ክፍል 174", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/174.mp3", "assets/images/reading-book.jpg", "ክፍል 174", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 177 , 20, "ክፍል 175", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/175.mp3", "assets/images/reading-book.jpg", "ክፍል 175", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 178 , 20, "ክፍል 176", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/176.mp3", "assets/images/reading-book.jpg", "ክፍል 176", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 179 , 20, "ክፍል 177", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/177.mp3", "assets/images/reading-book.jpg", "ክፍል 177", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 180 , 20, "ክፍል 178", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/178.mp3", "assets/images/reading-book.jpg", "ክፍል 178", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 181 , 20, "ክፍል 179", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/179.mp3", "assets/images/reading-book.jpg", "ክፍል 179", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 182 , 20, "ክፍል 180", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/180.mp3", "assets/images/reading-book.jpg", "ክፍል 180", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 183 , 20, "ክፍል 181", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/181.mp3", "assets/images/reading-book.jpg", "ክፍል 181", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 184 , 20, "ክፍል 182", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/182.mp3", "assets/images/reading-book.jpg", "ክፍል 182", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 185 , 20, "ክፍል 183", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/183.mp3", "assets/images/reading-book.jpg", "ክፍል 183", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 186 , 20, "ክፍል 184", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/184.mp3", "assets/images/reading-book.jpg", "ክፍል 184", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 187 , 20, "ክፍል 185", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/185.mp3", "assets/images/reading-book.jpg", "ክፍል 185", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 188 , 20, "ክፍል 186", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/186.mp3", "assets/images/reading-book.jpg", "ክፍል 186", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 189 , 20, "ክፍል 187", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/187.mp3", "assets/images/reading-book.jpg", "ክፍል 187", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 190 , 20, "ክፍል 188", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/188.mp3", "assets/images/reading-book.jpg", "ክፍል 188", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 191 , 20, "ክፍል 189", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/189.mp3", "assets/images/reading-book.jpg", "ክፍል 189", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 192 , 20, "ክፍል 190", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/190.mp3", "assets/images/reading-book.jpg", "ክፍል 190", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 193 , 20, "ክፍል 191", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/191.mp3", "assets/images/reading-book.jpg", "ክፍል 191", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 194 , 20, "ክፍል 192", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/192.mp3", "assets/images/reading-book.jpg", "ክፍል 192", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 195 , 20, "ክፍል 193", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/193.mp3", "assets/images/reading-book.jpg", "ክፍል 193", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 196 , 20, "ክፍል 194", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/194.mp3", "assets/images/reading-book.jpg", "ክፍል 194", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 197 , 20, "ክፍል 195", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/195.mp3", "assets/images/reading-book.jpg", "ክፍል 195", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 198 , 20, "ክፍል 196", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/196.mp3", "assets/images/reading-book.jpg", "ክፍል 196", NULL, 0, 0);
 
 
 -- 7/3/2020 METSAFE_MENEKOSAT - መጽሐፈ መነኮሳት አረጋዊ መንፈሳዊ
 INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 1, 23, "መግቢያ ፩", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/-1.wma", "assets/images/reading-book.jpg", "መግቢያ ፩", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 2, 23, "መግቢያ ፪", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/-2.wma", "assets/images/reading-book.jpg", "መግቢያ ፪", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 3, 23, "መግቢያ ፫", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/0.wma", "assets/images/reading-book.jpg", "መግቢያ ፫", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 4, 23, "ክፍል 1", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/1.mp3", "assets/images/reading-book.jpg", "ክፍል 1", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 5, 23, "ክፍል 2", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/2.mp3", "assets/images/reading-book.jpg", "ክፍል 2", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 6, 23, "ክፍል 3", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/3.mp3", "assets/images/reading-book.jpg", "ክፍል 3", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 7, 23, "ክፍል 4", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/4.mp3", "assets/images/reading-book.jpg", "ክፍል 4", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 8, 23, "ክፍል 5", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/5.mp3", "assets/images/reading-book.jpg", "ክፍል 5", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES( 9, 23, "ክፍል 6", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/6.mp3", "assets/images/reading-book.jpg", "ክፍል 6", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(10 , 23, "ክፍል 7 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/7 .mp3", "assets/images/reading-book.jpg", "ክፍል 7 ", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(11 , 23, "ክፍል 8 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/8 .mp3", "assets/images/reading-book.jpg", "ክፍል 8 ", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(12 , 23, "ክፍል 9 ", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/9 .mp3", "assets/images/reading-book.jpg", "ክፍል 9 ", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(13 , 23, "ክፍል 10", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/10.mp3", "assets/images/reading-book.jpg", "ክፍል 10", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(14 , 23, "ክፍል 11", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/11.mp3", "assets/images/reading-book.jpg", "ክፍል 11", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(15 , 23, "ክፍል 12", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/12.mp3", "assets/images/reading-book.jpg", "ክፍል 12", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(16 , 23, "ክፍል 13", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/13.mp3", "assets/images/reading-book.jpg", "ክፍል 13", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(17 , 23, "ክፍል 14", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/14.mp3", "assets/images/reading-book.jpg", "ክፍል 14", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(18 , 23, "ክፍል 15", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/15.mp3", "assets/images/reading-book.jpg", "ክፍል 15", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(19 , 23, "ክፍል 16", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/16.mp3", "assets/images/reading-book.jpg", "ክፍል 16", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(20 , 23, "ክፍል 17", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/17.mp3", "assets/images/reading-book.jpg", "ክፍል 17", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(21 , 23, "ክፍል 18", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/18.mp3", "assets/images/reading-book.jpg", "ክፍል 18", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(22 , 23, "ክፍል 19", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/19.mp3", "assets/images/reading-book.jpg", "ክፍል 19", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(23 , 23, "ክፍል 20", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/20.mp3", "assets/images/reading-book.jpg", "ክፍል 20", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(24 , 23, "ክፍል 21", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/21.mp3", "assets/images/reading-book.jpg", "ክፍል 21", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(25 , 23, "ክፍል 22", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/22.mp3", "assets/images/reading-book.jpg", "ክፍል 22", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(26 , 23, "ክፍል 23", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/23.mp3", "assets/images/reading-book.jpg", "ክፍል 23", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(27 , 23, "ክፍል 24", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/24.mp3", "assets/images/reading-book.jpg", "ክፍል 24", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(28 , 23, "ክፍል 25", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/25.mp3", "assets/images/reading-book.jpg", "ክፍል 25", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(29 , 23, "ክፍል 26", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/26.mp3", "assets/images/reading-book.jpg", "ክፍል 26", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(30 , 23, "ክፍል 27", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/27.mp3", "assets/images/reading-book.jpg", "ክፍል 27", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(31 , 23, "ክፍል 28", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/28.mp3", "assets/images/reading-book.jpg", "ክፍል 28", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(32 , 23, "ክፍል 29", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/29.mp3", "assets/images/reading-book.jpg", "ክፍል 29", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(33 , 23, "ክፍል 30", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/30.mp3", "assets/images/reading-book.jpg", "ክፍል 30", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(34 , 23, "ክፍል 31", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/31.mp3", "assets/images/reading-book.jpg", "ክፍል 31", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(35 , 23, "ክፍል 32", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/32.mp3", "assets/images/reading-book.jpg", "ክፍል 32", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(36 , 23, "ክፍል 33", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/33.mp3", "assets/images/reading-book.jpg", "ክፍል 33", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(37 , 23, "ክፍል 34", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/34.mp3", "assets/images/reading-book.jpg", "ክፍል 34", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(38 , 23, "ክፍል 35", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/35.mp3", "assets/images/reading-book.jpg", "ክፍል 35", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(39 , 23, "ክፍል 36", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/36.mp3", "assets/images/reading-book.jpg", "ክፍል 36", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(40 , 23, "ክፍል 37", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/37.mp3", "assets/images/reading-book.jpg", "ክፍል 37", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(41 , 23, "ክፍል 38", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/38.mp3", "assets/images/reading-book.jpg", "ክፍል 38", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(42 , 23, "ክፍል 39", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/39.mp3", "assets/images/reading-book.jpg", "ክፍል 39", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(43 , 23, "ክፍል 40", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/40.mp3", "assets/images/reading-book.jpg", "ክፍል 40", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(44 , 23, "ክፍል 41", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/41.mp3", "assets/images/reading-book.jpg", "ክፍል 41", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(45 , 23, "ክፍል 42", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/42.mp3", "assets/images/reading-book.jpg", "ክፍል 42", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(46 , 23, "ክፍል 43", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/43.mp3", "assets/images/reading-book.jpg", "ክፍል 43", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(47 , 23, "ክፍል 44", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/44.mp3", "assets/images/reading-book.jpg", "ክፍል 44", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(48 , 23, "ክፍል 45", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/45.mp3", "assets/images/reading-book.jpg", "ክፍል 45", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(49 , 23, "ክፍል 46", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/46.mp3", "assets/images/reading-book.jpg", "ክፍል 46", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(50 , 23, "ክፍል 47", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/47.mp3", "assets/images/reading-book.jpg", "ክፍል 47", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(51 , 23, "ክፍል 48", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/48.mp3", "assets/images/reading-book.jpg", "ክፍል 48", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(52 , 23, "ክፍል 49", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/49.mp3", "assets/images/reading-book.jpg", "ክፍል 49", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(53 , 23, "ክፍል 50", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/50.mp3", "assets/images/reading-book.jpg", "ክፍል 50", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(54 , 23, "ክፍል 51", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/51.mp3", "assets/images/reading-book.jpg", "ክፍል 51", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(55 , 23, "ክፍል 52", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/52.mp3", "assets/images/reading-book.jpg", "ክፍል 52", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(56 , 23, "ክፍል 53", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/53.mp3", "assets/images/reading-book.jpg", "ክፍል 53", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(57 , 23, "ክፍል 54", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/54.mp3", "assets/images/reading-book.jpg", "ክፍል 54", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(58 , 23, "ክፍል 55", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/55.mp3", "assets/images/reading-book.jpg", "ክፍል 55", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(59 , 23, "ክፍል 56", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/56.mp3", "assets/images/reading-book.jpg", "ክፍል 56", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(60 , 23, "ክፍል 57", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/57.mp3", "assets/images/reading-book.jpg", "ክፍል 57", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(61 , 23, "ክፍል 58", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/58.mp3", "assets/images/reading-book.jpg", "ክፍል 58", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(62 , 23, "ክፍል 59", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/59.mp3", "assets/images/reading-book.jpg", "ክፍል 59", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(63 , 23, "ክፍል 60", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/60.mp3", "assets/images/reading-book.jpg", "ክፍል 60", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(64 , 23, "ክፍል 61", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/61.mp3", "assets/images/reading-book.jpg", "ክፍል 61", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(65 , 23, "ክፍል 62", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/62.mp3", "assets/images/reading-book.jpg", "ክፍል 62", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(66 , 23, "ክፍል 63", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/63.mp3", "assets/images/reading-book.jpg", "ክፍል 63", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(67 , 23, "ክፍል 64", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/64.mp3", "assets/images/reading-book.jpg", "ክፍል 64", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(68 , 23, "ክፍል 65", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/65.mp3", "assets/images/reading-book.jpg", "ክፍል 65", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(69 , 23, "ክፍል 66", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/66.mp3", "assets/images/reading-book.jpg", "ክፍል 66", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(70 , 23, "ክፍል 67", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/67.mp3", "assets/images/reading-book.jpg", "ክፍል 67", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(71 , 23, "ክፍል 68", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/68.mp3", "assets/images/reading-book.jpg", "ክፍል 68", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(72 , 23, "ክፍል 69", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/69.mp3", "assets/images/reading-book.jpg", "ክፍል 69", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(73 , 23, "ክፍል 70", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/70.mp3", "assets/images/reading-book.jpg", "ክፍል 70", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(74 , 23, "ክፍል 71", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/71.mp3", "assets/images/reading-book.jpg", "ክፍል 71", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(75 , 23, "ክፍል 72", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/72.mp3", "assets/images/reading-book.jpg", "ክፍል 72", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(76 , 23, "ክፍል 73", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/73.mp3", "assets/images/reading-book.jpg", "ክፍል 73", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(77 , 23, "ክፍል 74", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/74.mp3", "assets/images/reading-book.jpg", "ክፍል 74", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(78 , 23, "ክፍል 75", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/75.mp3", "assets/images/reading-book.jpg", "ክፍል 75", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(79 , 23, "ክፍል 76", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/76.mp3", "assets/images/reading-book.jpg", "ክፍል 76", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(80 , 23, "ክፍል 77", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/77.mp3", "assets/images/reading-book.jpg", "ክፍል 77", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(81 , 23, "ክፍል 78", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/78.mp3", "assets/images/reading-book.jpg", "ክፍል 78", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(82 , 23, "ክፍል 79", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/79.mp3", "assets/images/reading-book.jpg", "ክፍል 79", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(83 , 23, "ክፍል 80", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/80.mp3", "assets/images/reading-book.jpg", "ክፍል 80", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(84 , 23, "ክፍል 81", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/81.mp3", "assets/images/reading-book.jpg", "ክፍል 81", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(85 , 23, "ክፍል 82", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/82.mp3", "assets/images/reading-book.jpg", "ክፍል 82", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(86 , 23, "ክፍል 83", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/83.mp3", "assets/images/reading-book.jpg", "ክፍል 83", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(87 , 23, "ክፍል 84", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/84.mp3", "assets/images/reading-book.jpg", "ክፍል 84", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(88 , 23, "ክፍል 85", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/85.mp3", "assets/images/reading-book.jpg", "ክፍል 85", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(89 , 23, "ክፍል 86", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/86.mp3", "assets/images/reading-book.jpg", "ክፍል 86", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(90 , 23, "ክፍል 87", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/87.mp3", "assets/images/reading-book.jpg", "ክፍል 87", NULL, 0, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED, IS_OPENED) 
 VALUES(91 , 23, "ክፍል 88", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/AregawiMenfesawi/88.mp3", "assets/images/reading-book.jpg", "ክፍል 88", NULL, 0, 0);


COMMIT;