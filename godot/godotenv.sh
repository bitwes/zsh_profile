#!/bin/zsh

# ##############################################################################
# Utilities for setting the GODOT environment variable.  Uses
# $ZSHFILES/bin/godotenv_tools ruby script for some stuff.  I hate bash.
# ##############################################################################


export GODOT_BUILDS_DIR="/Users/butchwesley/development/godot/godot_engine/builds"
# -----------------------
# GODOT_SV_ vars are "special versions".  If the value is a version number then
# it will be found in /Applications the same way other version numbers are
# found.  Otherwise it is treated as an absolute path to Godot binary.
#
# Make as many as you want.  Use these with godotenv by sending whatever follows
# "GODOT_SV_" in the variable name.  For example, with these you can do:
#   godotenv build
#   godotenv 3
#
# These should probably be moved to mac_godot.zsh, but then I'd have to explain
# things there and here.
export GODOT_SV_3="3.5.3"     # Default Godot 3 version I am using
export GODOT_SV_4_4="4.4.1"     # Default Godot 4 version I am using
export GODOT_SV_4='4.5'
# export GODOT_SV_build="/Users/butchwesley/development/godot/godot_engine/godot_latest/bin/godot.macos.editor.arm64"
# export GODOT_SV_4_5_CUSTOM="/Users/butchwesley/development/godot/godot_engine/builds/godot_4.5.custom"
# -----------------------


# #############################
# Private
# #############################
function _change_godot_version(){
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
        _change_godot_version $@
    fi
}