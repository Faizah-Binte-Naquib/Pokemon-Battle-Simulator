--Created by G. M. Shahariar Shibli
clear screen;

--delete existing table
drop table Pokemon cascade constraints;
drop table Move cascade constraints;
drop table Damage cascade constraints;

--Create Pokemon, Move, Damage database
create table Pokemon(
pokeid     	integer, 
pokename   	varchar2(30), 
hp     		integer, 
attack  	integer,
defense  	integer,
sp_attack  	integer,
sp_defense 	integer,
speed 	    integer,
poketype 		varchar2(10),
region 		varchar2(10), 
		PRIMARY KEY (pokeid)
);

create table Move(
movid    		integer, 
movname  		varchar2(30),
movpower		integer, 
pp 				integer,
movtype 		varchar2(30), 
critical		integer,
minhit			integer,
maxhit			integer,
			PRIMARY KEY(movid)
);

create table Damage(
did   		integer, 
attack   	varchar2(10), 
defense  	varchar2(10), 
dvalue		float,
			PRIMARY KEY(did)
);

--Insert data into the Pokemon database
insert into Pokemon values(1,'Bulbasaur',45,49,49,65,65,45,'Grass','Kanto');
insert into Pokemon values(2,'Charmander',39,52,43,60,50,65,'Fire','Kanto');
insert into Pokemon values(3,'Squirtle',44,48,65,50,64,43,'Water','Kanto');
insert into Pokemon values(4,'Pikachu',35,55,40,50,50,90,'Electric','Kanto');
insert into Pokemon values(5,'Meowth',40,45,35,40,40,90,'Normal','Kanto');





--Insert data into Move database
--NORMAL TYPE ATTACKS
insert into Move values(1,'Razor Wind',80,10,'Normal',1,1,1);
insert into Move values(2,'Horn Attack',65,25,'Normal',0,1,1);
insert into Move values(3,'Head Butt',70,15,'Normal',0,1,1);
insert into Move values(4,'Spike Cannon',20,15,'Normal',0,2,5);
insert into Move values(5,'Horn Attack',65,25,'Normal',0,1,1);
--FIRE TYPE ATTACKS
insert into Move values(6,'Blaze Kick',85,10,'Fire',1,1,1);
insert into Move values(7,'Ember',40,25,'Fire',0,1,1);
insert into Move values(8,'Fire Fang',65,15,'Fire',0,1,1);
insert into Move values(9,'Flame Thrower',90,15,'Fire',0,1,1);
insert into Move values(10,'Fire Charge',50,20,'Fire',0,1,1);
--WATER TYPE ATTACKS
insert into Move values(11,'Aqua Tail',90,10,'Water',0,1,1);
insert into Move values(12,'Snipe Shot',80,15,'Water',1,1,1);
insert into Move values(13,'Water Shuriken',15,20,'Water',0,2,5);
insert into Move values(14,'Water Fall',80,15,'Water',0,1,1);
insert into Move values(15,'Hydro Pump',50,20,'Water',0,1,1);
--ELECTRIC TYPE ATTACKS
insert into Move values(16,'Zippy Zap',50,15,'Electric',1,1,1);
insert into Move values(17,'Discharge',80,15,'Electric',0,1,1);
insert into Move values(18,'Thunderbolt',90,15,'Electric',0,1,1);
insert into Move values(19,'Thunder',110,10,'Electric',0,1,1);
--GRASS TYPE ATTACKS
insert into Move values(20,'Leaf Blade',90,15,'Grass',1,1,1);
insert into Move values(21,'Razor Leaf',55,25,'Grass',1,1,1);
insert into Move values(22,'Seed Bomb',80,15,'Grass',0,1,1);
insert into Move values(23,'Bullet Seed',25,30,'Grass',0,2,5);



--Insert data into Damage database
insert into Damage values(1,'Normal','Normal', 1);
insert into Damage values(2,'Normal','Fire', 1);
insert into Damage values(3,'Normal','Water', 1);
insert into Damage values(4,'Normal','Grass', 1);
insert into Damage values(5,'Normal','Elictric', 1);
insert into Damage values(6,'Fire','Normal', 1);
insert into Damage values(7,'Fire','Water', 0.5);
insert into Damage values(8,'Fire','Fire', 0.5);
insert into Damage values(9,'Fire','Grass', 2);
insert into Damage values(10,'Fire','Electric', 1);
insert into Damage values(11,'Water','Normal', 1);
insert into Damage values(12,'Water','Fire', 2);
insert into Damage values(13,'Water','Water', 0.5);
insert into Damage values(14,'Water','Grass', 0.5);
insert into Damage values(15,'Water','Electric', 1);
insert into Damage values(16,'Electric','Normal', 1);
insert into Damage values(17,'Electric','Fire', 1);
insert into Damage values(18,'Electric','Water', 2);
insert into Damage values(19,'Electric','Grass', 0.5);
insert into Damage values(20,'Electric','Electric', 0.5);
insert into Damage values(21,'Grass','Normal', 1);
insert into Damage values(22,'Grass','Fire', 0.5);
insert into Damage values(23,'Grass','Water', 2);
insert into Damage values(24,'Grass','Grass', 0.5);
insert into Damage values(25,'Grass','Electric', 1);
commit;

--Display all data from three databases
select * from Pokemon;
select * from Move;
select * from Damage;

