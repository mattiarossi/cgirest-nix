#!/bin/sh
BASEDIR="/sys/fs/cgroup/"
CGROUP="$BASEDIR$1"
TASK="$2"

if [ ! -d "$CGROUP" ]; then
  # Error, can't find cgroup
  echo "Error! cgroup $CGROUP is not defined!"
  exit 1
fi

FINDTASK="/proc/$TASK"

if [ ! -d "$FINDTASK" ]; then
  # Error, can't find task
  echo "Error! task $TASK doesn't exist!"
  exit 1
fi

#Perform the move
echo "Assigning task $TASK to group $CGROUP"
echo  "$TASK" > "$CGROUP/tasks"
echo "..done"

