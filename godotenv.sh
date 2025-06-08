#!/bin/zsh

export GODOT="NOT_SET"
# -----------------------
# GODOT_SV_ vars are "special versions".  If the value is a version number then
# it will be found in /Applications the same way other version numbers are
# found.  Otherwise it is treated as an absolute path to Godot binary.
#
# Make as many as you want.
export GODOT_SV_4="4.3"
export GODOT_SV_3="3.5.3"
export GODOT_SV_build="/Users/butchwesley/development/godot/godot_engine/godot_latest/bin/godot.macos.editor.arm64"
# -----------------------


# #############################
# Private
# #############################
function _switch_to_godot_version2(){
    app=$1

    godotpath="$(godotenv_tools -s $app)"
    if [ $? -ne 0 ]; then
        echo $godotpath
    else
        export GODOT="${godotpath}"
        _list_godotenv
    fi
}


function _list_godotenv(){
    echo "\$GODOT = $GODOT"
    echo "\$GUT   = $GUT"

    if [ -e $GODOT ]; then
        godot --version
    elif [ $GODOT != "NOT_SET" ]; then
        echo "$GODOT does not exist."
    fi
}

# #############################
# Public
# #############################


function godotenv(){
    if [ -z $1 ]; then
        _list_godotenv
    elif [ $1 = "-l" ]; then
        godotenv_tools -l
    else
        _switch_to_godot_version2 $@
    fi
}