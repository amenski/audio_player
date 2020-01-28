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
	"is_downloaded"	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id, category_id)
);
CREATE TABLE IF NOT EXISTS "category" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"title"	TEXT NOT NULL,
	"description"	TEXT,
	"sub_category_id"	INTEGER,
	"thumb_url"	TEXT
);
COMMIT;

-- categories
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, SUB_CATEGORY_ID,THUMB_URL) VALUES("1", "በንባብ/ Audio books","በንባብ/ Audio books", NULL , NULL);

-- sub-categories
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, SUB_CATEGORY_ID,THUMB_URL) VALUES("20", "መጽሀፈ መነኮሳት ፊልክስዮስ","መጽሀፈ መነኮሳት ፊልክስዮስ", 1 , NULL);
INSERT INTO CATEGORY(ID,TITLE,DESCRIPTION, SUB_CATEGORY_ID,THUMB_URL) VALUES("21", "ሃይማኖተ አበው","ሃይማኖተ አበው", 1 , NULL);


-- posts
--METSAFE_MENEKOSAT
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 1, 20, "መግቢያ ፩", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-1.mp3", NULL, "መግቢያ ፩",0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 2, 20, "መግቢያ ፪", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-2.mp3", NULL, "መግቢያ ፪",0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 3, 20, "ክፍል 1", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/1.mp3", NULL, "ክፍል 1",0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 4, 20, "ክፍል 2", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/2.mp3", NULL, "ክፍል 2",0);

INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 5, 20, "ክፍል 3", "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/3.mp3", NULL, "ክፍል 3",0);
	
	
-- HAYMANOTE_ABEW
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 1, 21, "መቅድም", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3", NULL, "መቅድም",0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 2, 21, "መግለጫ", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Meglecha.mp3", NULL, "መግለጫ",0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 3, 21, "ታሪክ", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3", NULL, "ታሪክ",0);
	
INSERT INTO POST(ID, CATEGORY_ID, TITLE, URL, THUMB_URL, DESCRIPTION, IS_DOWNLOADED) 
	VALUES( 4, 21, "ምዕራፍ ፩", "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/chapter1.mp3", NULL, "ምዕራፍ ፩/Chapter 1",0);
