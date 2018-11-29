function mvntest(){
  local script=''

  if [ $1 ]; then
    script=" -Dtest=$1 "
  fi

  mvn clean; mvn test $script
}
