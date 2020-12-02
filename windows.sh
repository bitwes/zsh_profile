# Overwrite the cls function defined in cls.sh
function cls(){
  if [ -f "$ZSHFILES/cls.txt" ]; then
    _cls_from_file $ZSHFILES/cls.txt
  else
    _cls_from_loop
  fi
  clear # screen # windows doesn't like "screen"
}


alias explorer="explorer.exe ."
export DEVELOPMENT='/mnt/e/butch/development/godot'
export WIN_HOME='/mnt/c/Users/Butch'

alias ext='exit 0'

# goto linux home instead of windows home.  this could get annoying
# when relaoding config.
cd
