CREATE table if not exists Singer (
	ID serial primary key,
	Singer_Name varchar(50) unique not null
);

CREATE table if not exists Album (
	ID serial primary key,
	Album_Name varchar(40) unique not null,
	Album_Date date 
);

CREATE table if not exists Singer_Album (
	ID serial primary key,	
	Singer_ID integer references Singer(ID),
	Album_ID integer references Album(ID)
);

CREATE table if not exists Genre (
	ID serial primary key,
	Genre_Name varchar(40) unique not null
);

CREATE table if not exists Singer_Genre (
	ID serial primary key,
	Singer_ID integer references Singer(ID),
	Genre_ID integer references Genre(ID)
);

CREATE table if not exists Track (
	ID serial primary key,
	Track_Name varchar(40) unique not null,
	Album_ID integer references Album(ID),	
	Duration numeric check(duration > 0 and duration < 120),
	Genre_ID integer references Genre(ID)
);

CREATE table if not exists Collection_Album (
	ID serial primary key,
	Collection_Album_Name varchar(40) unique not null,
	Collection_Album_Date date 
);

CREATE table if not exists Collection_Album_Track (
	ID serial primary key,
	Collection_Album_ID integer references Collection_Album(ID),
	Track_ID integer references Track(ID)
);

CREATE table if not exists Staff (
	ID serial primary key,
	Staff_Name varchar(40) not null,
	Department varchar(40) not null,
	Chief boolean
)
