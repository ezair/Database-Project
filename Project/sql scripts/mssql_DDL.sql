create table _user
	(
		email varchar(50) not null,
		
		username varchar(20)
			check (len(username) >= 5),
		
		password varchar(20)
			check (len(password) >= 8),
		
		primary key (email)
	);


create table _character
	(
		ID  integer,

		email varchar(50) not null,

		name varchar(20)
			check (len(name) >= 5 and len(name) <= 15),

		skin numeric(20),

		primary key (ID),

		foreign key (email) references _user(email)
	);


create table _has 
	(
		email varchar(50) not null,
		
		ID integer not null,

		primary key(email, ID),

		foreign key (email) references _user(email),

		foreign key (ID) references _character(ID)
	);


create table _weapon
	(
		weapon_id integer,
		
		character_id integer,
		
		name varchar(20)
			check (len(name) >= 5),
		
		damage_rate integer
			check (damage_rate >= 0 and damage_rate <= 9999),

		foreign key (character_id) references _character(ID),

		primary key (weapon_id)
	);


create table _owns
	(
		ID integer,

		weapon_id integer,

		primary key (ID, weapon_id),

		foreign key (ID) references _character(ID),

		foreign key (weapon_id) references _weapon(weapon_id) 
	);


create table _enemy
	(
		enemy_name varchar(30),
		
		health integer
			check (health >= 0 and health <= 9999),

		speed integer
			check (speed >= 0 and speed <= 9999),

		mesh integer,

		primary key (enemy_name)
	);


create table _world
	(
		world_name varchar(20),

		type integer,

		time datetime,

		primary key(world_name)
	);


create table _contains
	(
		world_id integer,

		ID integer,

		foreign key (ID) references _character(ID),

		primary key(ID, world_id)
	);


create table _fights
	(
		ID integer,

		enemy_name varchar(30),
		
		foreign key (enemy_name) references _enemy(enemy_name),

		foreign key (ID) references _character(ID),

		primary key(ID, enemy_name) 	
	);


	/* This command below is to make sure that the user
	   cannot enter any special characters into the database
	   for any given user name.
	*/
	ALTER TABLE _user 
		ADD CONSTRAINT ck_No_Special_Characters 
			CHECK (username NOT LIKE '%[^A-Z0-9].@%'),
			CHECK (password NOT LIKE '%[^A-Z0-9.@]%'),
			CHECK (email NOT LIKE '%[^A-Z0-9.@]%')


	/* This command below is to make sure that the user
	   cannot enter any special characters into the database
	   for any given character name.
	*/
	ALTER TABLE _character
		ADD CONSTRAINT ck_No_Special_Characters_in_name
			CHECK (name NOT LIKE '%[^A-Z0-9].@%')