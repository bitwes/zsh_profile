#!/bin/bash

#------------------------------------------------------
#used by cls, shouldn't be called alone.  Mostly just
#practice with loops and ifs.
#------------------------------------------------------
function _cls_from_loop(){
  local i=0
  local other=r
  echo "${txtpur}"
  for VAR in {1..40}
  do
    if [ $i -eq 0 ]
    then
      other=' |'
    elif [ $i -eq 1 ]
    then
      other=' /'
    elif [ $i -eq 2 ]
    then
      other='|'
    elif [ $i -eq 3 ]
    then
      other=" \\"
    fi

    echo "          $other"

    let "i += 1"

    if [ $i -eq 4 ]
    then
      i=0
    fi
  done
  echo "${txtrst}"
}

#------------------------------------------------------
#used by cls, shouldn't be called alone
#------------------------------------------------------
function _cls_from_file(){
  echo "${txtred}"
  cat "$1"
  echo "${txtrst}"
}

#------------------------------------------------------
#Clears the screen but first it prints a divider so if
#you scroll up it maintains some semblance of a seperation
#that you wanted when you cleared the screen.  if
#cls.txt exists then it will print the contents
#from there, otherwise it loops through and prints out
#the wavy line that was a way for me to learn vars,
#looping, and if statements.
#------------------------------------------------------
function cls(){
  if [ -f "$ZSHFILES/cls.txt" ]; then
    _cls_from_file $ZSHFILES/cls.txt
  else
    _cls_from_loop
  fi
  clear screen
}
