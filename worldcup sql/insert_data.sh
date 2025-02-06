#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clear existing data before inserting new values
$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;"

# Read the CSV file and insert data
FIRST_LINE=true
while IFS="," read -r year round winner opponent winner_goals opponent_goals
do
  # Skip the first line (header)
  if $FIRST_LINE; then
    FIRST_LINE=false
    continue
  fi

  # Insert winner team if not exists
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
  if [[ -z $WINNER_ID ]]; then
    $PSQL "INSERT INTO teams(name) VALUES('$winner')"
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
  fi

  # Insert opponent team if not exists
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
  if [[ -z $OPPONENT_ID ]]; then
    $PSQL "INSERT INTO teams(name) VALUES('$opponent')"
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
  fi

  # Insert game record with retrieved team IDs
  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
         VALUES($year, '$round', $WINNER_ID, $OPPONENT_ID, $winner_goals, $opponent_goals)"
done < games.csv
