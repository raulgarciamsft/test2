cmake_minimum_required(VERSION 3.10)

project("PR Test2" VERSION 0.0.1 LANGUAGES C)

enable_testing()

# Allow us to import cmake scripts from  ./cmake
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

add_library(prtest2
    ${PROJECT_SOURCE_DIR}/src/Test2a.c
)

# Compiler flags
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(prtest2 PRIVATE -Wall -Wextra -pedantic -pedantic-errors -Wunreachable-code -Wmissing-field-initializers)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    target_compile_options(prtest2 PRIVATE -Wgnu-empty-initializer)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    target_compile_options(prtest2 PRIVATE -Wenum-compare)
endif()

# Set the public include directory depending on if the target is being exported
# or installed
target_include_directories(prtest2
    SYSTEM PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    PRIVATE
        ${PROJECT_SOURCE_DIR}/src/prtest2
)

# Install the prtest2 library in the default location, and associate
# prtest2 with the prtest2 export
install(TARGETS prtest2 EXPORT prtest2)

# Install public header files
install(
    DIRECTORY ${PROJECT_SOURCE_DIR}/include/prtest2
    TYPE INCLUDE
    FILES_MATCHING PATTERN "*.h*"
)

# Generate the build-tree prtest2Config.cmake for use in other cmake
# projects without needing to install
export(
    EXPORT prtest2
    FILE "${CMAKE_CURRENT_BINARY_DIR}/prtest2/prtest2Config.cmake"
)

# Generate the install-tree prtest2Config.cmake for use in other cmake
# projects after this library has been installed
install(
    EXPORT prtest2
    FILE prtest2Config.cmake
    DESTINATION lib/cmake/prtest2
)

add_subdirectory(docs)

file(MAKE_DIRECTORY  "${CMAKE_CURRENT_BINARY_DIR}/simple_build")
add_test(NAME build_simple
   COMMAND "${CMAKE_COMMAND}"
      -E env prtest2_DIR=${CMAKE_CURRENT_BINARY_DIR}/prtest2
      "${CMAKE_CTEST_COMMAND}"
        --build-and-test "${PROJECT_SOURCE_DIR}/examples/simple" "${CMAKE_CURRENT_BINARY_DIR}/simple_build"
        --build-generator ${CMAKE_GENERATOR}
        --test-command simple
)
