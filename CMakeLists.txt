cmake_minimum_required(VERSION 3.14)

project("ElectionGuard SDK" VERSION 0.0.1 LANGUAGES C)

enable_testing()

# Allow us to import cmake scripts from  ./cmake
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

add_library(test2
    ${PROJECT_SOURCE_DIR}/src/test2a.c
    ${PROJECT_SOURCE_DIR}/include/test2/test2a.h
)

# Compiler flags
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(test2 PUBLIC -Werror -Wall -Wextra -pedantic -pedantic-errors -Wunreachable-code -Wmissing-field-initializers -lgmp)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    target_compile_options(test2 PUBLIC -Werror --fsanitize=address -Wgnu-empty-initializer)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    target_compile_options(test2 PUBLIC -Werror -Wenum-compare)
endif()

# Link gmp library
find_package(GMP REQUIRED)
target_link_libraries(test2 ${GMP_LIBRARY})

if (MINGW)
    # Remove lib prefix
    set_target_properties(test2 PROPERTIES PREFIX "")
endif()

# Set the public include directory depending on if the target is being exported
# or installed
target_include_directories(test2
    SYSTEM PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${GMP_INCLUDE_DIR}>
    PRIVATE
        ${PROJECT_SOURCE_DIR}/src/test2
)

# Install the test2 library in the default location, and associate
# test2 with the test2 export
install(TARGETS test2 EXPORT Test2)

# Install public header files
install(
    DIRECTORY ${PROJECT_SOURCE_DIR}/include/test2
    TYPE INCLUDE
    FILES_MATCHING PATTERN "*.h*"
)

# Generate the build-tree Test2Config.cmake for use in other cmake
# projects without needing to install
export(
    EXPORT Test2
    FILE "${CMAKE_CURRENT_BINARY_DIR}/Test2/Test2Config.cmake"
)

# Generate the install-tree Test2Config.cmake for use in other cmake
# projects after this library has been installed
install(
    EXPORT Test2
    FILE Test2Config.cmake
    DESTINATION lib/cmake/Test2
)

add_subdirectory(docs)

file(MAKE_DIRECTORY  "${CMAKE_CURRENT_BINARY_DIR}/simple_build")
set(CMAKE_CONFIGURATION_TYPES "Debug" CACHE STRING "" FORCE)

add_test(NAME build_simple
   COMMAND "${CMAKE_COMMAND}"
      -E env Test2_DIR=${CMAKE_CURRENT_BINARY_DIR}/Test2
      "${CMAKE_CTEST_COMMAND}"
        --build-and-test "${PROJECT_SOURCE_DIR}/examples/simple" "${CMAKE_CURRENT_BINARY_DIR}/simple_build"
        --build-generator ${CMAKE_GENERATOR}
        --test-command simple
)

include(CheckIncludeFiles)
#check_include_files("windows.h" HAVE_BCRYPTGENRANDOM)
#configure_file(${PROJECT_SOURCE_DIR}/src/test2/random_source.h.in ${PROJECT_SOURCE_DIR}/src/electionguard/random_source.h)
