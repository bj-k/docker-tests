#!/bin/bash
########### Symbolic link DB files ############

########### SIGINT handler ############
function startDb() {
   echo "Starting database."
   java -cp h2*.jar org.h2.tools.Server \
    	-web -webAllowOthers -webPort 81 \
    	-tcp -tcpAllowOthers -tcpPort 1521 \
    	-baseDir ${H2_DATA_DIR} > $H2_LOG & childPID=$!
   echo "H2 PID: $childPID"
}

function _int() {
   echo "Stopping container."
   echo "SIGINT received, shutting down database!"
   java -cp h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:1521
}

########### SIGTERM handler ############
function _term() {
   echo "Stopping container."
   echo "SIGTERM received, shutting down database!"
   java -cp h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:1521
}

########### SIGKILL handler ############
function _kill() {
   echo "SIGKILL received, shutting down database!"
   java -cp h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:1521
}

# Set SIGINT handler
trap _int SIGINT

# Set SIGTERM handler
trap _term SIGTERM

# Set SIGKILL handler
trap _kill SIGKILL

startDb;
# Check whether database already exists
if [ -d $H2_CONTAINER_CREATED ]; then
  echo "Database has already been created"
else
  echo "Execute custom provided setup scripts"
  $H2_SCRIPTS_DIR/runUserScripts.sh $H2_SQL
  touch $H2_CONTAINER_CREATED
fi;

# Tail on log and wait (otherwise container will exit)

echo "The following output is now a tail of the output log:"
tail -n100 -f --pid=$childPID $H2_LOG &
tailPID=$!
echo "Tail PID: $tailPID"
ps
wait $tailPID
