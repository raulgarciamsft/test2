# CMake generated Testfile for 
# Source directory: F:/Code/test2
# Build directory: F:/Code/test2/out/build/x64-Debug
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(build_simple "C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe" "-E" "env" "prtest2_DIR=F:/Code/test2/out/build/x64-Debug/prtest2" "C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/ctest.exe" "--build-and-test" "F:/Code/test2/examples/simple" "F:/Code/test2/out/build/x64-Debug/simple_build" "--build-generator" "Ninja" "--test-command" "simple")
set_tests_properties(build_simple PROPERTIES  _BACKTRACE_TRIPLES "F:/Code/test2/CMakeLists.txt;68;add_test;F:/Code/test2/CMakeLists.txt;0;")
subdirs("docs")
