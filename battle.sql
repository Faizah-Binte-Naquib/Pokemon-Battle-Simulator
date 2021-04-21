SET SERVEROUTPUT ON;
declare
  --Declaring indexing variables
  i integer:=1;
  j integer:=1;
  total integer:=0;
  same integer:=0;
  n integer;
  
  --Declaring arrays to store move details
  type namesarray IS VARRAY(4) OF VARCHAR2(30);
  type typesarray IS VARRAY(4) OF VARCHAR2(30);
  type pparray IS VARRAY(4) OF INTEGER;
  type powerarray IS VARRAY(4) OF INTEGER;
  type criticalarray IS VARRAY(4) OF INTEGER;
  --setting moves for pokemon 1
  move_name namesarray:= namesarray();
  move_type typesarray:= typesarray();
  move_pp pparray:= pparray();
  move_power powerarray:= powerarray();
  move_critical criticalarray;
  --setting moves for pokemon 2
  b_move_name namesarray:= namesarray();
  b_move_type typesarray:= typesarray();
  b_move_pp pparray:= pparray();
  b_move_power powerarray:= powerarray();
  b_move_critical criticalarray;
  --Enter pokemon and opponent pokemon along with their levels
  my_poke_name pokemon.pokename%TYPE:='&your_pokemon_name';
  my_poke_level integer:=&insert_your_pokemon_level;
  opponent_poke_name pokemon.pokename%TYPE:='&opponent_pokemon_name';
  opponent_poke_level integer:=&insert_opponent_pokemon_level;
  --variables to store details of pokemon 1
  Pokemon_name pokemon.pokename%TYPE;
  Pokemon_type pokemon.poketype%TYPE;
  Pokemon_hp pokemon.hp%TYPE;
  Pokemon_attack pokemon.attack%TYPE;
  Pokemon_defense pokemon.defense%TYPE;
  Pokemon_spattack pokemon.sp_attack%TYPE;
  Pokemon_spdefense pokemon.sp_defense%TYPE;
  Pokemon_speed pokemon.speed%TYPE;
  --variables to store details of pokemon 2
  b_Pokemon_name pokemon.pokename%TYPE;
  b_Pokemon_type pokemon.poketype%TYPE;
  b_Pokemon_hp pokemon.hp%TYPE;
  b_Pokemon_attack pokemon.attack%TYPE;
  b_Pokemon_defense pokemon.defense%TYPE;
  b_Pokemon_spattack pokemon.sp_attack%TYPE;
  b_Pokemon_spdefense pokemon.sp_defense%TYPE;
  b_Pokemon_speed pokemon.speed%TYPE;
  
  --other variables required for storing battle infor
  attacker varchar2(10);
  defender varchar2(10);
  move integer;
  damage float;
  steps integer:=0;
  
begin


	--FIXING ATTRIBUTES AND ATTACKS FOR POKEMON A
	FOR R IN (SELECT * FROM pokemon where pokename like my_poke_name) LOOP
	Pokemon_type:=R.poketype;
	Pokemon_name:=R.pokename;
	Pokemon_attack:=R.attack;
	Pokemon_hp:=R.hp;
	Pokemon_defense:=R.defense;
	END LOOP;
	
	FOR R IN (SELECT * FROM move where movtype = Pokemon_type OR movtype = 'Normal'  order by dbms_random.value) LOOP
	total:= move_name.count;
	if(total>0) then
	for j in 1..total loop
		if(move_name(j)=R.movname) then
		same:=1;
		end if;
	end loop;
	end if;
	if(total=0 or same=0) then
	move_name.extend; 
    move_name(i)  := R.movname;
	move_type.extend; 
    move_type(i)  := R.movtype;
	move_power.extend; 
    move_power(i)  := R.movpower;
	move_pp.extend; 
    move_pp(i)  := R.pp;
	i:=i+1;
	else
	same:=0;
	end if;
	
	if(i=5)then
	exit;
	end if;
	
	END LOOP;
	
	--RESETTING i,same,count to 0
	i:=1;
	same:=0;
	total:=0;
	
	--FIXING ATTRIBUTES AND ATTACKS FOR POKEMON B
	FOR R IN (SELECT * FROM pokemon where pokename like opponent_poke_name) LOOP
	b_Pokemon_type:=R.poketype;
	b_Pokemon_name:=R.pokename;
	b_Pokemon_defense:=R.defense;
	b_Pokemon_attack:=R.attack;
	b_Pokemon_hp:=R.hp;
	END LOOP;
	
	FOR R IN (SELECT * FROM move where movtype = b_Pokemon_type OR movtype = 'Normal'  order by dbms_random.value) LOOP
	total:= b_move_name.count;
	if(total>0) then
	for j in 1..total loop
		if(b_move_name(j)=R.movname) then
		same:=1;
		end if;
	end loop;
	end if;
	if(total=0 or same=0) then
	b_move_name.extend; 
    b_move_name(i)  := R.movname;
	b_move_type.extend; 
    b_move_type(i)  := R.movtype;
	b_move_power.extend; 
    b_move_power(i)  := R.movpower;
	b_move_pp.extend; 
    b_move_pp(i)  := R.pp;	
	i:=i+1;
	else
	same:=0;
	end if;
	
	if(i=5)then
	exit;
	end if;
	
	END LOOP;	
   
   
	--SHOWING THE SELECTED ATTACKS FOR BOTH POKEMONS
	dbms_output.put_line('...');
	dbms_output.put_line('Selected Moves for '||my_poke_name);
	for i in 1..4 loop
	dbms_output.put_line('Move:'||i||':'||move_name(i));
	end loop;
	dbms_output.put_line('...');
    dbms_output.put_line('Selected Moves for '||opponent_poke_name);	
	for i in 1..4 loop
	dbms_output.put_line('Move'||i||':'||b_move_name(i));
	end loop;
	
	dbms_output.put_line('...');
	--SELECTING WHO GETS THE FIRST MOVE 
	n := dbms_random.value(1,2);	
	if n=1 then
	dbms_output.put_line(Pokemon_name||' '||'gets the first move');
	else
	dbms_output.put_line(b_Pokemon_name||' '||'gets the first move');
	end if; 
--	WHILE TRUE
--	LOOP
	
--	END LOOP
	dbms_output.put_line('-------------------');
	dbms_output.put_line('...BATTLE BEGINS...');
	dbms_output.put_line('-------------------');
	WHILE TRUE LOOP
	
	--  						ROUND  01					-- 
	--IF 1 THEN POKEMON A GETS THE FIRST MOVE SO IT IS APPOINTED AS THE ATTACKER AND VICE-VERSA
	if n=1 then
	steps:=steps+1;
	attacker:=Pokemon_name;
	defender:=b_Pokemon_name;
	--PICK A RANDOM ATTACK 
    i:= dbms_random.value(1,4);
	--APPLY THE ATTACK ON THE OPPONENT AND CALCULATE DAMAGE move_power(i) move_type(i)
	damage:=calculate_Damage(my_poke_level,Pokemon_attack,move_power(i),b_Pokemon_defense,move_type(i),b_Pokemon_type,Pokemon_type);
	move_pp(i):=move_pp(i)-1;
	b_Pokemon_hp:=b_Pokemon_hp-damage;
	dbms_output.put_line('M'||steps||' '||attacker||' '||'damaged'||' '||defender||' '||'for '||damage||' HP'||' , '||attacker||' '||'pp for '||move_name(i)||' is '||move_pp(i));
	--CHECKING IF DEFENDER HAS ANY HP LEFT
	if b_Pokemon_hp<=0 then
	dbms_output.put_line(attacker||' Wins! ');
	exit;
	end if;	
	
	else
	steps:=steps+1;
	attacker:=b_Pokemon_name;
	defender:=Pokemon_name;
	--PICK A RANDOM ATTACK 
    i:= dbms_random.value(1,4);
	--APPLY THE ATTACK ON THE OPPONENT AND CALCULATE DAMAGE move_power(i) move_type(i)
	damage:=calculate_Damage(opponent_poke_level,b_Pokemon_attack,b_move_power(i),Pokemon_defense,b_move_type(i),Pokemon_type,b_Pokemon_type);
	b_move_pp(i):=b_move_pp(i)-1;
	Pokemon_hp:=Pokemon_hp-damage;
	dbms_output.put_line('M'||steps||' '||attacker||' '||'damaged'||' '||defender||' '||'for '||damage||' HP'||' , '||attacker||' '||'pp for '||b_move_name(i)||' is '||b_move_pp(i));
	
	--CHECKING IF DEFENDER HAS ANY HP LEFT
	if Pokemon_hp<=0 then
	dbms_output.put_line(attacker||' Wins! ');
	exit;
	end if;	
	
	end if;
	




	--  						ROUND  02					-- 	
	if n=1 then
	steps:=steps+1;
	attacker:=b_Pokemon_name;
	defender:=Pokemon_name;
	--PICK A RANDOM ATTACK 
    i:= dbms_random.value(1,4);
	--APPLY THE ATTACK ON THE OPPONENT AND CALCULATE DAMAGE move_power(i) move_type(i)
	damage:=calculate_Damage(opponent_poke_level,b_Pokemon_attack,b_move_power(i),Pokemon_defense,b_move_type(i),Pokemon_type,b_Pokemon_type);
	b_move_pp(i):=b_move_pp(i)-1;
	Pokemon_hp:=Pokemon_hp-damage;
	dbms_output.put_line('M'||steps||' '||attacker||' '||'damaged'||' '||defender||' '||'for '||damage||' HP'||' , '||attacker||' '||'pp for '||b_move_name(i)||' is '||b_move_pp(i));
	--CHECKING IF DEFENDER HAS ANY HP LEFT
	if Pokemon_hp<=0 then
	dbms_output.put_line(attacker||' Wins! ');
	exit;
	end if;	
	
	else
	steps:=steps+1;
	attacker:=Pokemon_name;
	defender:=b_Pokemon_name;
	--PICK A RANDOM ATTACK 
    i:= dbms_random.value(1,4);
	--APPLY THE ATTACK ON THE OPPONENT AND CALCULATE DAMAGE move_power(i) move_type(i)
	damage:=calculate_Damage(my_poke_level,Pokemon_attack,move_power(i),b_Pokemon_defense,move_type(i),b_Pokemon_type,Pokemon_type);
	move_pp(i):=move_pp(i)-1;
	b_Pokemon_hp:=b_Pokemon_hp-damage;
	dbms_output.put_line('M'||steps||' '||attacker||' '||'damaged'||' '||defender||' '||'for '||damage||' HP'||' , '||attacker||' '||'pp for '||move_name(i)||' is '||move_pp(i));
	
	--CHECKING IF DEFENDER HAS ANY HP LEFT
	if b_Pokemon_hp<=0 then
	dbms_output.put_line(attacker||' Wins! ');
	exit;
	end if;	
	
	end if;

	END LOOP;
   
end;
/