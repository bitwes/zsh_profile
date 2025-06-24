#!/bin/zsh

# Original "gdt" alias was "git diff-tree --no-commit-id --name-only -r"

# ------------------------------------------------------------------------------
# The following must be setup per platform for this script to work
#
# export GODOT=''
# ------------------------------------------------------------------------------
alias gdt_loc="find . -name '*.gd' | xargs wc -l"


# ------------------------------------------------------------------------------
# Lists all the functions in a gd script file.  It searches from the current
# directory down for any files named $1.  It can optionally filter on a method
# name from $2.
#
# Parameters
# -----------
# $1:  the name of the script
# $2:  (optional) pattern for functions
# ------------------------------------------------------------------------------
function gdt_list_functions(){
	local cmd="find ./ -name $1 -exec cat {} \; |  grep -n 'func '"

	if [[ -n $2 ]]; then
		cmd="$cmd | grep $2"
	fi
	eval $cmd
}

# ------------------------------------------------------------------------------
# Lists all the classes in a gd script file.  This searches the same way that
# list_functions does.
#
# Parameters
# -----------
# $1:  the name of the script
# $2:  (optional) pattern for functions
# ------------------------------------------------------------------------------
function gdt_list_classes(){
	local cmd="find ./ -name $1 -exec cat {} \; |  grep -n 'class '"

	if [[ -n $2 ]]; then
		cmd="$cmd | grep $2"
	fi
	eval $cmd
}


# ------------------------------------------------------------------------------
# print out accessors for the passed in property.  It also copies them to the
# clipboard.
# ------------------------------------------------------------------------------
function gdt_accessor() {
	name=${1#"_"}
	tab=$'\t'

	read -r -d '' OUTPUT  <<EOM
func get_$name():
${tab}return $1

func set_$name($name):
${tab}$1 = $name
EOM
  echo "$OUTPUT"
	echo "$OUTPUT" | pbcopy
}

function godot_proj_info(){
	local p=$PWD
	if [ $1 ]; then
		p=`readlink -f $1`
	fi
	gdcmd $ZSHFILES/godot/godot_proj_info.gd ++ --path $p $@
}