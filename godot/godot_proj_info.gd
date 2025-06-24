#!gdcmd
extends SceneTree

var OptParse = load("./optparse.gd")


func _parse_options():
	var opts = OptParse.new()
	opts.banner = \
"""
Prints out project.godot fields to tell you base information about a projet.
"""
	opts.add_required("--path", "", "The absolute path to a godot project root directory.")
	opts.add(["--help", "-h"], false, "help")

	# This will parse OS.get_cmdline_args and OS.get_cmdline_user_args.  You
	# can pass any array into this though and limit which arguments you want
	# to process.
	opts.parse()
	return opts


func _print_proj_info(path_to_proj_file):
	var cf = ConfigFile.new()
	cf.load(path_to_proj_file)

	var features = cf.get_value("application", "config/features", [])
	if(features.size() == 0):
		print("This is probably a Godot 3 project")
	else:
		print("Features:  ", features)


func _init():
	var opts = _parse_options()
	var missing = opts.get_missing_required_options()

	if(opts.get_value("--help")):
		opts.print_help()
		quit(0)
	elif(missing.size() > 0):
		print('Required options missing')
		for m in missing:
			print('  ', m.to_s())
		quit(1)
	else:
		var d = DirAccess.open("./")
		var proj_file_path = opts.get_value("--path").path_join("project.godot")
		if(d.file_exists(proj_file_path)):
			_print_proj_info(proj_file_path)
		else:
			print("Not a Godot project base directory.")
	quit()