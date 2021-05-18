#!/bin/zsh
say_set_name(){
  alias say="say -v '$*' "
}

say_show_names() {
  say -v '?'
}

alias cpwd='pwd | pbcopy;pwd'
export IOS_SIMULATORS="/Users/butchwesley/Library/Developer/CoreSimulator/Devices/"