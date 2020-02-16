/*
* DB script
*/

-- ddl
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "post" (
	"id"	INTEGER,
	"category_id"	INTEGER NOT NULL,
	"title"	TEXT NOT NULL,
	"url"	TEXT NOT NULL,
	"thumb_url"	TEXT,
	"description"	TEXT,
	"download_path" TEXT,
	"is_downloaded"	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id, category_id)
);
CREATE TABLE IF NOT EXISTS "category" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"title"	TEXT NOT NULL,
	"description"	TEXT,
	"parent_category_id"	INTEGER,
	"thumb_url"	TEXT
);
COMMIT;

-- categories
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("1", "በንባብ/ Audio books","በንባብ/ Audio books", NULL , "assets/images/reading-book.jpg");

-- PARENT-categories
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("20", "መጽሀፈ መነኮሳት ፊልክስዮስ","መጽሀፈ መነኮሳት ፊልክስዮስ", 1 , "assets/images/reading-book.jpg");
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, PARENT_CATEGORY_ID,THUMB_URL) VALUES("21", "ሃይማኖተ አበው","ሃይማኖተ አበው", 1 , "assets/images/reading-book.jpg");


-- posts
-- METSAFE_MENEKOSAT
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 1, 20, "መግቢያ ፩", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-1.mp3", "assets/images/reading-book.jpg", "መግቢያ ፩", NULL, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 2, 20, "መግቢያ ፪", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-2.mp3", "assets/images/reading-book.jpg", "መግቢያ ፪", NULL, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 3, 20, "ክፍል 1", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/1.mp3", "assets/images/reading-book.jpg", "ክፍል 1", NULL, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 4, 20, "ክፍል 2", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/2.mp3", "assets/images/reading-book.jpg", "ክፍል 2", NULL, 0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 5, 20, "ክፍል 3", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/3.mp3", "assets/images/reading-book.jpg", "ክፍል 3", NULL, 0);
	
	
-- HAYMANOTE_ABEW
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 1, 21, "መቅድም", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3", "assets/images/reading-book.jpg", "መቅድም", NULL, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 2, 21, "መግለጫ", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Meglecha.mp3", "assets/images/reading-book.jpg", "መግለጫ", NULL, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 3, 21, "ታሪክ", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3", "assets/images/reading-book.jpg", "ታሪክ", NULL, 0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, DOWNLOAD_PATH, IS_DOWNLOADED) 
	VALUES( 4, 21, "ምዕራፍ ፩", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/chapter1.mp3", "assets/images/reading-book.jpg", "ምዕራፍ ፩/Chapter 1", NULL, 0);


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
