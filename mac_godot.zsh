# ------------------------------------------------------------------------------
# /Users/butchwesley/Library/Application Support/Godot/editor_settings-3.tres
#		lines that start with "projects/::" are the lines that define what shows
#   up when you launch gut.
# ------------------------------------------------------------------------------
export GODOT_ENGINE_DIR="/Users/butchwesley/development/godot/godot_engine/godot_latest"
export GODOT_USER_DIR=~/Library/Application\ Support/Godot/app_userdata
export GODOT_EDITOR_DIR=~/Library/Application\ Support/Godot/

# export GAME='/Users/butchwesley/development/godot/butch_game/ButchVBirds/game'
export BITOOLS='/Users/butchwesley/development/godot/BitoolsGodot'
# export GODOT_DEV_DIR='/Users/butchwesley/development/godot'

alias ngodot='open -n $GODOT'

dot_it ./godot/godot_main.sh
dot_it gut.sh


# alias adb='/Users/butchwesley/Library/Android/sdk/platform-tools/adb'
alias pixel_use_tcpip='adb tcpip 5555'
alias disconnect_pixel='adb usb'
func connect_pixel(){
  adb devices
  #adb tcpip 5555 (adb -s FA7B41A00312 tcpip 5555)
  adb connect 192.168.1.115
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


# animals=( ["moo"]="cow" ["woof"]="dog")
export MY_GODOT_TOOLS_DIR="/Users/butchwesley/development/godot/Godot4Projects/MyTools"
# key is the directory name in addons/, value is the directory name in MyTools
typeset -Agx MY_GODOT_TOOLS=(
  ["bitools"]="BitoolsGodot"
  ["editor_handles"]="EditorHandles"
  ["editor_linkables"]="EditorLinkables"
  ["input_recorder"]="InputRecorder" )


function godot_tools_list(){
  echo $MY_GODOT_TOOLS_DIR
  padding="                    "
  for key in ${(k)MY_GODOT_TOOLS};
    printf "%s%s %s\n" "  - $key" "${padding:${#key}}" "$MY_GODOT_TOOLS[$key]/addons/$key"
}


function cpgodot_tool_here(){
  local tool=''

  if [ $1 ]; then
    tool=$1
  else
    godot_tools_list
    return
  fi

  the_keys=${(k)MY_GODOT_TOOLS}
  idx=${the_keys[(Ie)$tool]}
  # echo "$tool index = $idx"

  if [ "$idx" -eq "0" ]; then
    godot_tools_list
    echo "UNKNOWN TOOL $tool"
  else
    # echo "it equals:  $MY_GODOT_TOOLS[$tool]"
    cp -r $MY_GODOT_TOOLS_DIR/$MY_GODOT_TOOLS[$tool]/addons/$tool/* ./addons/$tool/
  fi
}
