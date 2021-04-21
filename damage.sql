CREATE OR REPLACE FUNCTION calculate_Damage(a in integer,b in pokemon.attack%TYPE,c in move.movpower%TYPE,d in pokemon.defense%TYPE,
											attack_type in move.movtype%TYPE,defender_type in pokemon.poketype%TYPE,
											attacker_type in pokemon.poketype%TYPE) 
RETURN float IS 
   damage float:= 0;
   x float:=1;
   y float;
   z float;
   crit_mult float:=2;
  
BEGIN 

  --storing the damage magbnitude for the attack and defense 
  SELECT dvalue into y FROM damage  WHERE attack=attack_type AND defense=defender_type;
  
  --storing 1.5 in x if the attack type and attacker type is one and the same 
  if attack_type LIKE attacker_type then
  x:=1.5;
  end if;
  
  if a=0 then
  dbms_output.put_line('No value obtained');
  end if;
  --a : The level of the attacker.
  --b : The attacker's special attack or normal attack statistic.
  --c : The attacker's attack power statistic.
  --d : The defender's special defense or normal defense statistic.
  --x : Same type attack bonus to apply (1 or 1.5).
  --y : The type modifier statistic to apply.

  z:= dbms_random.value(217,256);
  damage := floor(((((crit_mult * a) / 5) + 2) * b * c) / d);
  damage := floor(damage / 50) + 2;
  damage := floor(damage * x);    
  damage := floor(damage * y);
  damage := floor((damage * z) / 255);
  RETURN damage;
END;
/