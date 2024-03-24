#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"



if [[ $1 ]]
then
  ELEMENT= $PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number JOIN types ON properties.type_id = types.type_id  WHERE elements.atomic_number=$1 OR name='$1' OR symbol='$1'"
  echo $ELEMENT
  echo "TEST"
else 
  echo "Please provide an element as an argument."
fi
