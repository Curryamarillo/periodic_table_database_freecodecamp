#!/bin/bash

# Enter database variable
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# Main function
MAIN_SCRIPT(){
# Input check
  if [[ -z $1 ]]; then
    echo -e "Please provide an element as an argument."

# Elif number check
  elif [[ $1 =~ ^[0-9]+$ ]]; then

  # Variables to get
    ATOMIC_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1;") | tr -d '[:space:]')
    ATOMIC_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$1;") | tr -d '[:space:]')
    ATOMIC_TYPE=$(echo $($PSQL "SELECT type FROM properties INNER JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    ATOMIC_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties INNER JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    MELTING_POINT=$(echo $($PSQL "SELECT melting_poinT_celsius FROM properties INNER JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1") | sed 's/^[ \t]*//')
    BOILING_POINT=$(echo $($PSQL "SELECT boiling_poinT_celsius FROM properties INNER JOIN types ON properties.type_id=types.type_id WHERE atomic_number=$1") | sed 's/^[ \t]*//')
  # Answer
    echo -e "The element with atomic number $1 is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
 
  # Elif symbol check, two characters
  elif [[ "$1" =~ ^[A-Z][a-z]{0,1}$ ]]; then

  # Variables to get
    ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'") | tr -d '[:space:]')
    ATOMIC_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE symbol='$1';") | tr -d '[:space:]')
    ATOMIC_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE symbol='$1';") | tr -d '[:space:]')
    ATOMIC_TYPE=$(echo $($PSQL "SELECT types.type FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.symbol='$1'") | sed 's/^[ \t]*//')
    ATOMIC_MASS=$(echo $($PSQL "SELECT properties.atomic_mass FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.symbol='$1'") | sed 's/^[ \t]*//')
    MELTING_POINT=$(echo $($PSQL "SELECT properties.melting_point_celsius FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.symbol='$1'") | sed 's/^[ \t]*//')
    BOILING_POINT=$(echo $($PSQL "SELECT properties.boiling_point_celsius FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.symbol='$1'") | sed 's/^[ \t]*//')
  # Answer
    echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
 
  # Elif checks name of the element
  elif [[ "$1" =~ ^[A-Z][a-z]+$  ]]; then
    ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE name='$1' ") | tr -d '[:space:]')
    ATOMIC_SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE name='$1';") | tr -d '[:space:]')
    ATOMIC_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE name='$1';") | tr -d '[:space:]')
    ATOMIC_TYPE=$(echo $($PSQL "SELECT types.type FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.name='$1'") | sed 's/^[ \t]*//')
    ATOMIC_MASS=$(echo $($PSQL "SELECT properties.atomic_mass FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.name='$1'") | sed 's/^[ \t]*//')
    MELTING_POINT=$(echo $($PSQL "SELECT properties.melting_point_celsius FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.name='$1'") | sed 's/^[ \t]*//')
    BOILING_POINT=$(echo $($PSQL "SELECT properties.boiling_point_celsius FROM properties INNER JOIN types ON properties.type_id = types.type_id INNER JOIN elements ON properties.atomic_number=elements.atomic_number WHERE elements.name='$1'") | sed 's/^[ \t]*//')
  # Answer
    echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  else
  # Not in database
  echo -e "I could not find that element in the database."
  fi
}

MAIN_SCRIPT "$1"