SET SERVEROUTPUT ON;

DECLARE
	Name pokemon.pokename%TYPE:='&insert_pokemon_name';
	Pokemon_name pokemon.pokename%TYPE;
	Pokemon_type pokemon.poketype%TYPE;
	Pokemon_hp pokemon.hp%TYPE;
	Pokemon_attack pokemon.attack%TYPE;
	Pokemon_defense pokemon.defense%TYPE;
	Pokemon_spattack pokemon.sp_attack%TYPE;
	Pokemon_spdefense pokemon.sp_defense%TYPE;
	Pokemon_speed pokemon.speed%TYPE;
BEGIN

	FOR R IN (SELECT * FROM pokemon where pokename = Name) LOOP
		Pokemon_name:=R.pokename;		
		Pokemon_type:=R.poketype;			
		Pokemon_hp:=R.hp;
		Pokemon_attack:=R.attack;
		Pokemon_defense:=R.defense;
		Pokemon_spattack:=R.sp_attack;	
		Pokemon_speed:=R.speed;
		
		DBMS_OUTPUT.PUT_LINE('POKEMON NAME'||'='||Pokemon_name);
		DBMS_OUTPUT.PUT_LINE('POKEMON TYPE'||'='||Pokemon_type);
		DBMS_OUTPUT.PUT_LINE('POKEMON TYPE'||'='||Pokemon_type);	
		DBMS_OUTPUT.PUT_LINE('HP'||'='||Pokemon_hp);
		DBMS_OUTPUT.PUT_LINE('POKEMON STATS');	
		DBMS_OUTPUT.PUT_LINE('ATTACK'||'='||Pokemon_attack);
		DBMS_OUTPUT.PUT_LINE('DEFENSE'||'='||Pokemon_defense);
		DBMS_OUTPUT.PUT_LINE('SP. ATTACK'||'='||Pokemon_spattack);	
		DBMS_OUTPUT.PUT_LINE('SP. DEFENSE'||'='||Pokemon_spdefense);
		DBMS_OUTPUT.PUT_LINE('SPEED'||'='||Pokemon_defense);	
	END LOOP;
	
	IF Pokemon_name is null THEN
	raise no_data_found;
	END IF;
	
	For s in (SELECT * FROM table_name ORDER BY RAND() LIMIT 1;)
	
EXCEPTION		
	when no_data_found then
		dbms_output.put_line('unknown');
	
END;
/