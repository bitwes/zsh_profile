export GODOT="NOT_SET"

alias godot='eval $GODOT'
alias godot_here='godot -e --path $PWD'
alias godot_import='godot --headless --import'
alias godot_project_here='touch project.godot'
alias gdscript='godot --path $PWD -s '

dot_it godot/godotenv.sh
dot_it godot/godot_engine_tools.sh
dot_it godot/godot_tools.sh