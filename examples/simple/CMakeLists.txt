cmake_minimum_required(VERSION 3.13)

project("test2 Simple Example Client" VERSION 0.0.1 LANGUAGES C)

enable_testing()

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_LIST_DIR}/../../cmake
    ${CMAKE_MODULE_PATH}
)

add_executable(simple
    ${PROJECT_SOURCE_DIR}/simple.c
)


find_package(test2 REQUIRED)

add_test(NAME simple COMMAND simple)

install(TARGETS simple)
