export GUT='/Users/butchwesley/development/godot/guts/Gut'

alias gut_output_tests='gdscript addons/gut/gut_cmdln.gd -gconfig= -gdir test/output_tests -gexit'
alias gut_change_warnings="godot -s addons/gut/cli/change_project_warnings.gd --headless ++"
alias gut_run_output_tests="gut '' '' -gdir res://test/output_tests"
alias gut="gdscript addons/gut/gut_cmdln.gd"
# alias cpgut_here='cp -rv $GUT/addons/gut/* ./addons/gut/'
alias cpgut_here='rsync -av $GUT/addons/gut ./addons'

# ------------------------------------------------------------------------------
# Run Gut.  This only works from the root directory of your game.
#
# Parameters
# ----------
# $1: (optional) specific script name (turns it into a -gselect gut option).
# $2: (optional) a string to filter test names with (turns it
#     into a -gunit_test_name gut option).
# $n: any options after the 2nd are sent to gut as is.  These could be godot
#     or gut options.
#
# If you want to specify options w/o specifying a script or test name you can
# pass '' for $1 and $2.  e.g. gut '' '' "-glog=99"
# ------------------------------------------------------------------------------
function gutsmart(){
  local script=''
  if [[ $1 ]]; then
    script=" -gselect=$1 "
  else
    script=""
  fi

  local t=''
  if [[ $2 ]]; then
    test=" -gunit_test_name=$2"
  else
    test=""
  fi

	local rest_of_args="$3 ${@:3}" # this is a bit of magic that I don't remember
  local options="--debug-collisions --path $PWD -d -s addons/gut/gut_cmdln.gd $script $test $rest_of_args"
	#local options="--path $PWD -s addons/gut/gut_cmdln.gd $script $test $rest_of_args"

	eval "$GODOT $options"
  echo "GUT quit with exit code $?"
}


# ------------------------------------------------------------------------------
# Installs GUT from github.
#
# Samples:
# install_gut "9.1.1" "tags"
#     https://github.com/bitwes/Gut/archive/refs/tags/v9.1.1.zip
# install_gut "godot_4_fix_utf8_issue" "heads"
#     https://github.com/bitwes/Gut/archive/refs/heads/godot_4_fix_utf8_issue.zip
# ------------------------------------------------------------------------------
function install_gut(){
  local gut_version=$1
  local where=$2

  local extra=""
  if [ $where = "tags" ]; then
    extra="v"
  fi

  mkdir ./__gut_install
  local gut_url="https://github.com/bitwes/Gut/archive/refs/${where}/${extra}${gut_version}.zip"
  echo $gut_url
  wget $gut_url -O ./__gut_install/gut.zip;
  unzip __gut_install/gut.zip -d ./__gut_install/
  rsync -av __gut_install/Gut-$gut_version/addons/ ./addons
  rm -r ./__gut_install
}


# example
function install_gut_tag(){
  install_gut "9.1.1" "tags"
}


# example
function install_gut_branch(){
  install_gut "godot_4_fix_utf8_issue" "heads"
}



# #####################
# Documentation
# #####################
function gut_generate_documentation(){
    zsh documentation/generate_rst.sh
}
alias gut_open_documentation='open /Users/butchwesley/development/godot/guts/Gut/documentation/docs/_build/html/index.html'
