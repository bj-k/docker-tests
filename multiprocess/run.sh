#!/bin/bash
########### Symbolic link DB files ############

########### SIGINT handler ############
function startScript1() {
   echo "Starting script1."
   sh script1.sh > log.txt & script1PID=$!
   echo "Script1 PID: $script1PID"
}

# startScript2(succeed|fail)
function startScript2() {
   echo "Starting script2 with param: $1"
   sh script2.sh $1
   local res=$?
   if [ $res -ne 0 ]
   then
     echo "Error executing script2: $res"
     exit -1
   fi
   echo "End script2."
}

function _int() {
   echo "Stopping container."
   echo "SIGINT received, shutting down!"
   exit 0;
}

########### SIGTERM handler ############
function _term() {
   echo "Stopping container."
   echo "SIGTERM received, shutting down!"
   exit 0;
}

########### SIGKILL handler ############
function _kill() {
   echo "SIGKILL received, shutting down!"
   exit 0;
}

# Set SIGINT handler
trap _int SIGINT

# Set SIGTERM handler
trap _term SIGTERM

# Set SIGKILL handler
trap _kill SIGKILL

echo "Arguments: $@"

startScript1;

startScript2 $1;

# Tail on log and wait (otherwise container will exit)
echo "The following output is now a tail of the output log:"
tail -n100 -f --pid=$script1PID log.txt &
tailPID=$!
echo "Tail PID: $tailPID"
ps -ef
wait $tailPID
