#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


#Check if any argument was passed
if [[ $1 ]]
then

#Check if argument is a letter and query in the database
  if [[ $1 =~ [a-zA-Z] ]]
  then
    ELEMENT=$($PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number JOIN types ON properties.type_id = types.type_id  WHERE name='$1' OR symbol='$1'")
  else
    ELEMENT=$($PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number JOIN types ON properties.type_id = types.type_id  WHERE elements.atomic_number=$1")
  fi
  
#Answer, whether it exists or not
  if [[ -z "$ELEMENT" ]]
  then
    echo "I could not find that element in the database."
  else
     IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< $ELEMENT
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
#If no argument has been passed
else 
  echo "Please provide an element as an argument."
fi
