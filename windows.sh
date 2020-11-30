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



# Windows Godot tools section
export GODOT='/mnt/c/Program\ Files/godot/Godot_v3.2.3-stable_win64.exe'
alias godot='eval $GODOT'

alias godot_here='godot -e --path $PWD' # hijacks the prompt with godot output.
alias gdscript='godot --path $PWD -s '
alias cpgut_here='echo "nope"'


function _swith_to_godot_version(){
#   app=$1
#   export GODOT="/Applications/${app}/Contents/MacOS/Godot"
#   godot --version
#   echo $GODOT
}

func switch_to_godot_322(){
#   _swith_to_godot_version "Godot_3.2.2.app"
    echo "nope"
}

func switch_to_godot_32(){
#   _swith_to_godot_version "Godot_3.2.app"
    echo "nope"
}

func switch_to_godot_324_beta(){
#   _swith_to_godot_version "Godot_3.2.4_beta.app"
    echo "nope"
}

function switch_to_godot_default(){
#   _swith_to_godot_version "Godot.app"
    echo "nope"
}


# goto linux home instead of windows home.  this could get annoying
# when relaoding config.
cd
