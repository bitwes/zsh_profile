# https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_macos.html
#   * Removed threads param since default is to use all but 1.
#   * Removed `generate_bundle=yes` because running tests through the .app was causing
#     permission errors for file access.
#   * ? Should use `compiledb=yes` for VSCode stuff?
# This command should generate ./bin/godot.macos.editor.arm64
alias goen_macos_dev_compile="scons platform=macos arch=arm64 target=editor dev_mode=yes tests=yes"

# https://docs.godotengine.org/en/stable/contributing/development/core_and_modules/unit_testing.html#doc-unit-testing
# https://github.com/doctest/doctest/tree/master
#
# Run doctest tests
#
# Examples:
# ---------
# ge_run_tests -ltc -ts="*[GDScript]*"
#   List all test cases for all suites that contain [GDScript]
# ge_run_tests -ts="*[GDScript]" -tc="*butch*"
#   Run gdscript tests based on the name of the .gd script?
alias goen_run_tests="bin/godot.macos.editor.arm64 --test"


alias goen_generate_test_out_files="godot --gdscript-generate-tests modules/gdscript/tests/scripts"