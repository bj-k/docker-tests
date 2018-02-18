#!/bin/bash
SCRIPTS_ROOT="$1";

# Check whether parameter has been passed on
if [ -z "$SCRIPTS_ROOT" ]; then
   echo "$0: No SCRIPTS_ROOT passed on, no scripts will be run";
   exit 1;
fi;

# Execute custom provided files (only if directory exists and has files in it)
if [ -d "$SCRIPTS_ROOT" ] && [ -n "$(ls -A $SCRIPTS_ROOT)" ]; then

  echo "";
  echo "Executing user defined scripts"

  for f in $SCRIPTS_ROOT/*; do
      case "$f" in
          # *.sh)     echo "$0: running $f"; . "$f" ;;
          # get prefix for db name: mydb_script1.sql, mydb.sql -> mydb
          *.sql)    echo "$0: running $f"; dbname=$(echo "${f##*/}" | cut -d '-' -f1 | cut -d '.' -f1); echo "DB name is: $dbname"; java -cp h2*.jar org.h2.tools.RunScript -url jdbc:h2:tcp://localhost:1521/$dbname -user sa -script $f; echo "Return: $?" ;;
          *)        echo "$0: ignoring $f" ;;
      esac
      echo "";
  done

  echo "DONE: Executing user defined scripts"
  echo "";

fi;
