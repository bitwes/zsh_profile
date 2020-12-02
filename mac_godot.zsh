# ------------------------------------------------------------------------------
# /Users/butchwesley/Library/Application Support/Godot/editor_settings-3.tres
#		lines that start with "projects/::" are the lines that define what shows
#   up when you launch gut.
# ------------------------------------------------------------------------------
export GODOT='/Applications/Godot.app/Contents/MacOS/Godot'


alias ngodot='open -n $GODOT'
alias cpgut_here='cp -r $GUT/addons/gut/* ./addons/gut/'


# ------------------------------------------------------------------------------
# Pixel stuff
# ------------------------------------------------------------------------------
alias adb='/Users/butchwesley/Library/Android/sdk/platform-tools/adb'
func connect_pixel(){
  adb devices
  #adb tcpip 5555 (adb -s FA7B41A00312 tcpip 5555)
  adb connect 192.168.1.115
}
alias disconnect_pixel='adb usb'


# ------------------------------------------------------------------------------
# Godot version switching
# ------------------------------------------------------------------------------
function _swith_to_godot_version(){
  app=$1
  export GODOT="/Applications/${app}/Contents/MacOS/Godot"
  godot --version
  echo $GODOT
}

func switch_to_godot_322(){
  _swith_to_godot_version "Godot_3.2.2.app"
}

func switch_to_godot_32(){
  _swith_to_godot_version "Godot_3.2.app"
}

func switch_to_godot_324_beta(){
  _swith_to_godot_version "Godot_3.2.4_beta_2.app"
}

function switch_to_godot_default(){
  _swith_to_godot_version "Godot.app"
}

dot_it godot_tools
