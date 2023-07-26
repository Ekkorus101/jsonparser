cmake_minimum_required(VERSION 3.24.1)
# set (CMAKE_C_COMPILER /opt/homebrew/opt/llvm/bin/clang)
# set (CMAKE_CXX_COMPILER /opt/homebrew/opt/llvm/bin/clang++)
# set (DFLAGS "-L/opt/homebrew/opt/libomp/lib")
# set (CPPFLAGS "-I/opt/homebrew/opt/libomp/include")

project(compiler)

include_directories(./build)
find_package(OpenMP)

set(SRC_DIR "src")
set(PARSER_DIR "${CMAKE_CURRENT_BINARY_DIR}")

find_package(FLEX 2.6 REQUIRED)
find_package(BISON 3.0 REQUIRED)

set(LEXER_OUT "${PARSER_DIR}/lexer.cpp")
set(PARSER_OUT "${PARSER_DIR}/parser.cpp")

flex_target(LEXER "${SRC_DIR}/lexer.l" "${LEXER_OUT}" DEFINES_FILE "${PARSER_DIR}/lexer.hpp")
bison_target(PARSER "${SRC_DIR}/parser.y" "${PARSER_OUT}" DEFINES_FILE "${PARSER_DIR}/parser.hpp")
add_flex_bison_dependency(LEXER PARSER)

add_executable(calc "${SRC_DIR}/main.cpp" "${LEXER_OUT}" "${PARSER_OUT}")

target_include_directories(calc PRIVATE "${PARSER_DIR}")

# add_compile_options(-S -Wall)
