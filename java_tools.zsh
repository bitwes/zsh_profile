
PATH=$PATH:/Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS/

function mvntest(){
  local script=''

  if [ $1 ]; then
    script=" -Dtest=$1 "
  fi

  mvn clean; mvn test $script
}


# function idea(){
#   eval "/Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS/idea $@ &"
# }

function idea_here(){
  idea $PWD 2>&1 &
  disown
}
