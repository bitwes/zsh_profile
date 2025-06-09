# ------------------------------------------------------------------------------
# /Users/butchwesley/Library/Application Support/Godot/editor_settings-3.tres
#		lines that start with "projects/::" are the lines that define what shows
#   up when you launch gut.
# ------------------------------------------------------------------------------
# export GODOT='/Applications/Godot.app/Contents/MacOS/Godot'
export GODOT_USER_DIR=~/Library/Application\ Support/Godot/app_userdata
export GODOT_EDITOR_DIR=~/Library/Application\ Support/Godot/

# export GAME='/Users/butchwesley/development/godot/butch_game/ButchVBirds/game'
export BITOOLS='/Users/butchwesley/development/godot/BitoolsGodot'
# export GODOT_DEV_DIR='/Users/butchwesley/development/godot'

alias ngodot='open -n $GODOT'
alias cpbitools_here='cp -r $BITOOLS/addons/bitools/* ./addons/bitools/'
alias cpeditor_handles_here='cp -r $GODOT_DEV_DIR/EditorHandles/addons/editor_handles/* ./addons/editor_handles/'
alias cpeditor_linkables_here='cp -r $GODOT_DEV_DIR/EditorLinkables/addons/editor_linkables/* ./addons/editor_linkables/'

dot_it godot_tools
dot_it gut.sh


# alias adb='/Users/butchwesley/Library/Android/sdk/platform-tools/adb'
alias pixel_use_tcpip='adb tcpip 5555'
alias disconnect_pixel='adb usb'
func connect_pixel(){
  adb devices
  #adb tcpip 5555 (adb -s FA7B41A00312 tcpip 5555)
  adb connect 192.168.1.115
}


func cpall_godot_tools_here(){
  cpgut_here
  cpbitools_here
  cpeditor_handles_here
  cpeditor_linkables_here
}

# ------------------------------------------------------------------------------
# Pixel stuff
# ------------------------------------------------------------------------------
alias adb='/Users/butchwesley/Library/Android/sdk/platform-tools/adb'
func connect_pixel(){
  adb devices
  #adb tcpip 5555 (adb -s FA7B41A00312 tcpip 5555)
  adb connect 192.168.1.115
}


function extract_godot_app_from_dmg(){
  dmg=$1
  hdiutil attach $dmg
  filename=$(basename -- "$dmg")
  filename="${filename%.*}"
  app_path="/Volumes/$filename/$filename.app"
  echo "Getting $app_path"
  tree "$app_path"
  cp -r "$app_path" ./
  hdiutil detach /Volumes/$filename -force
}


# https://stackoverflow.com/questions/66891065/libprism-sw-dylib-cannot-be-opened-because-the-developer-cannot-be-verified-o
function pck_explorer(){
  sudo spctl --master-disable
  dotnet ~/Applications/GodotPCKExplorer/GodotPckExplorer.Console.dll "$@"
  sudo spctl --master-enable
}


function export_then_extract(){
  godot --headless --export-debug macOS "/Users/butchwesley/development/godot/export/NewGodot42.dmg"
  cd /Users/butchwesley/development/godot/export/
  extract_godot_app_from_dmg NewGodot42.dmg
  cd -
}